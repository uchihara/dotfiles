alias peco='peco --on-cancel error'
alias -g P='|peco'
alias -g git-br='$(git branch P)'
alias -g git-brr='$(git branch -r P)'
alias -g git-loa='$(git log --no-color --pretty=oneline --abbrev-commit P | awk "{print \$1}")'
alias -g git-ref='$(git reflog --no-color P | awk "{print \$1}")'
alias pushd-gem='pushd $(bundle show --paths P)'
alias -g ps-pid='$(ps auxwwf P | awk "{print \$2}")'
alias git-rebase-loa 'git rebase -i git-loa'

function edocker-cmd () {
  name=$1; shift
  cmd=$1; shift
  for host in $(ecs-hosts); do
    cid=$(ssh -t ec2-user@$host docker ps G $name | awk '{print $1}')
    ssh -t ec2-user@$host docker $cmd $cid "$@"
  done
}

function edocker-cmd-hosts () {
  args=`getopt h: $*`
  set -- $args
  echo "*: $*" | xxd
  for opt in $*; do
    echo "opt: $opt"
    case "$opt" in
      -h)
        hosts="$hosts $2"; shift; shift;;
      --)
        shift; break;;
    esac
  done
  cmd=$1; shift
  f=$1; shift
  for host in $hosts; do
    cid=$(ssh -t ec2-user@$host docker ps G $f | awk '{print $1}')
    ssh -t ec2-user@$host docker $cmd $cid "$@"
  done
}

alias -g ECID="ssh -t ec2-user@$host docker ps G $f | awk '{print $1}'"
alias edocker=ecs-docker
alias ecs-docker='ssh -t ec2-user@$(ecs-hosts) docker'
alias -g EH='ec2-user@$(ecs-hosts)'
alias ecs-hosts="aws ec2 describe-instances | jq -r '
    .Reservations[].Instances[] |
    select(.Tags != null) |
    select((.Tags | from_entries).Name != null) |
    select((.Tags | from_entries).Name | contains(\"EC2ContainerService\")) |
    [(.Tags | from_entries)[\"aws:cloudformation:stack-name\"], .PublicIpAddress, .InstanceId] |
    @tsv
  ' | sed -e 's/,/ /g' | sort P | awk '{print \$2}'"

function s3cat() {
  p=$(echo $1/ | sed -e's/\/\/$/\//')
  uri=s3://$(echo $p | sed -e 's/^s3:\/\///')
  for f in $(aws s3 ls $uri | sort -r | peco | awk '{print $4}'); do
    aws s3 cp $uri$f - | gzip -cd
  done
}

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(history -n 1 | \
        eval $tac | \
        awk '!_[$0]++' | \
        peco --initial-filter=SmartCase --query "$LBUFFER")
    CURSOR=$#BUFFER
}
zle -N peco-select-history

bindkey '^r' peco-select-history

function peco-select-git-add() {
    local SELECTED_FILE_TO_ADD="$(git status --porcelain | \
                                  peco --query "$LBUFFER" | \
                                  awk -F ' ' '{print $NF}')"
    if [ -n "$SELECTED_FILE_TO_ADD" ]; then
      BUFFER="git add $(echo "$SELECTED_FILE_TO_ADD" | tr '\n' ' ')"
      CURSOR=$#BUFFER
    fi
    zle accept-line
    # zle clear-screen
}
zle -N peco-select-git-add

bindkey "^g^a" peco-select-git-add

function peco-git-recent-branches () {
    local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads | \
        perl -pne 's{^refs/heads/}{}' | \
        peco)
    if [ -n "$selected_branch" ]; then
        BUFFER="git checkout ${selected_branch}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-git-recent-branches

bindkey "^g^b" peco-git-recent-branches

