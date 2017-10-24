alias -g P='|peco'
alias -g git-br='$(git branch P)'
alias -g git-brr='$(git branch -r P)'
alias -g git-loa='$(git log --no-color --pretty=oneline --abbrev-commit P | awk "{print \$1}")'
alias -g git-ref='$(git reflog --no-color P | awk "{print \$1}")'
alias pushd-gem='pushd $(bundle show --paths P)'
alias -g ps-pid='$(ps auxwwf P | awk "{print \$2}")'
alias git-rebase-loa 'git rebase -i git-loa'

function edocker-logs () {
  f=$1
  host=$(ecs-hosts)
  cid=$(ssh -t ec2-user@$host docker ps G $f | awk '{print $1}')
  ssh -t ec2-user@$host docker logs $cid
}

alias edocker=ecs-docker
alias ecs-docker='ssh -t ec2-user@$(ecs-hosts) docker'
alias -g EH='ec2-user@$(ecs-hosts)'
alias ecs-hosts="aws ec2 describe-instances | jq -r '
    .Reservations[].Instances[] |
    select((.Tags | from_entries).Name | contains(\"EC2ContainerService\")) |
    [(.Tags | from_entries)[\"aws:cloudformation:stack-name\"], .PublicIpAddress] |
    @tsv
  ' | sed -e 's/,/ /g' | sort P | awk '{print \$2}'"

function s3cat() {
  p=$(echo $1/ | sed -e's/\/\/$/\//')
  for f in $(aws s3 ls s3://$p | sort -r | peco | awk '{print $4}'); do
    aws s3 cp s3://$p$f - | gzip -cd
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

