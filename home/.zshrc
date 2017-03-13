#/bin/zsh

# for zsh
autoload -U compinit
compinit

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
[ -f /usr/local/share/zsh/site-functions/_aws ] && source /usr/local/share/zsh/site-functions/_aws
bindkey -e
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{green}%1v%f|)"

#PROMPT='%m:%~: '
PROMPT=$'%{\e[1m\e[4m%}%m:%~%{\e[0m%} : '
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt hist_ignore_dups
setopt share_history
setopt magic_equal_subst
setopt nonomatch
setopt extended_glob

zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-colors ""
WORDCHARS=${WORDCHARS:s,/,,}

if [ -d ~/.zsh.d ]; then
  for f in ~/.zsh.d/*/*.zsh; do
    source $f
  done
fi

command -v vim >/dev/null && alias vi=vim
if ls --color >/dev/null 2>&1; then
  alias ls='ls -FC --color=auto'
else
  alias ls='ls -FCG'
fi

alias java='java -Dfile.encoding=UTF-8'
alias javac='javac -encoding UTF-8 -J-Dfile.encoding=UTF-8'
alias s3cmd='s3cmd --encoding=UTF-8'
alias grep='grep -I'
alias fgrep='fgrep -I'
alias egrep='egrep -I'
alias -g G='|grep'
alias -g L='|less'
alias -g LR='|less -R'
alias -g J='|jq'
alias -g RJ='|ruby -rjson -e"puts JSON.pretty_generate(JSON.parse(gets))"'
alias ssp='ssh proxy.sc'
alias sspj='ssh proxyjp.sc'
alias sccons='(cd ~/src/webapp/tonchidot/console/bin; php sekaicamera-console.php)'
alias clear2="echo -e '\026\033c'"
alias multitail='multitail -T -cT ansi -m 1000'
alias be='bundle exec'
alias -g PC='| pbcopy'
alias mux=tmuxinator

if [ -f ~/.ssh-agent-info ]; then
	source ~/.ssh-agent-info
fi

function sa_start() {
	ssh-agent >~/.ssh-agent-info
	source ~/.ssh-agent-info
	ssh-add
}

function sa_stop() {
	eval `ssh-agent -k`
	rm -f ~/.ssh-agent-info
}

function gitresetfile() {
  for f in "$@"; do
    rm "$f" && git co "$f"
  done
}

function cleanup-git-branches() {
  for br in $(git branch | sed -e's/[\* ]*//'); do
    case $br in
      master|develop|wk)
      ;;

      *)
      git branch -d $br
      ;;
    esac
  done
}

function git-hash(){
  branch=${1-HEAD}
  git log --no-color --oneline --branches $branch | peco | awk '{print $1}'
}

alias -g GH='$(git-hash)'

alias -g UD='| iconv -f UTF-8 -t UCS-4BE | xxd'
function ud() {
  echo -n $1 UD
}

function between() {
  first=$1
  last=$2

  if [ ! -z "$last" ]; then
    re="(${first}.*)${last}"
  else
    re="(${first}.*)"

  fi
  perl -ne 'BEGIN { $/ = undef; } print $1 if(/'$re'/s)'
}

PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin; export PATH
MANPATH=/usr/local/share/man:/usr/share/man; export MANPATH
LIBRARY_PATH=/usr/local/lib:/usr/lib; export LIBRARY_PATH
C_INCLUDE_PATH=/usr/local/include:/usr/include; export C_INCLUDE_PATH
CPLUS_INCLUDE_PATH=/usr/local/include:/usr/include; export CPLUS_INCLUDE_PATH
if [ -x /usr/bin/ccache ]; then
	CC='/usr/bin/ccache gcc'; export CC
	CXX='/usr/bin/ccache g++'; export CXX
fi

export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

PATH=$PATH:~/Library/Developer/android-sdk/tools; export PATH
PATH=$PATH:~/Library/Developer/android-sdk/platform-tools; export PATH
ANDROIDNDK_HOME=~/Library/Developer/android-ndk; export ANDROIDNDK_HOME
PATH=$PATH:$ANDROIDNDK_HOME; export PATH

EDITOR=vim; export EDITOR
LESS=-R; export LESS

# for amazon ec2
if [ -d /usr/lib/jvm/default-java ]; then
	JAVA_HOME=/usr/lib/jvm/default-java; export JAVA_HOME
	EC2_PRIVATE_KEY=~/Documents/pk-*.pem; export EC2_PRIVATE_KEY
	EC2_CERT=~/Documents/cert-*.pem; export EC2_CERT
fi

if [ `uname` = Darwin ]; then

  if [ -x java ]; then
    export JAVA_HOME="$(/usr/libexec/java_home)"
  fi
  export EC2_PRIVATE_KEY="$(/bin/ls $HOME/.ec2/pk-*.pem 2>/dev/null)"
  export EC2_CERT="$(/bin/ls $HOME/.ec2/cert-*.pem 2>/dev/null)"
fi

[[ -f ~/.aws-cred ]] && source ~/.aws-cred

#
PATH=~/bin:$PATH

# Load RVM into a shell session *as a function*
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
which peco >/dev/null && [[ -s ~/.peco-snippet ]] && source ~/.peco-snippet

export RUBY_GC_MALLOC_LIMIT=600000000
export RUBY_GC_HEAP_FREE_SLOTS=40960
export RUBY_GC_HEAP_INIT_SLOTS=100000

PATH=$PATH:/usr/local/share/npm/bin

PATH=$PATH:~/.rbenv/bin
eval "$(rbenv init -)"

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

[ -f ~/.ssh-agent-linker ] && source ~/.ssh-agent-linker

[ -x kubectl ] && source "$(kubectl completion zsh)"

alias kube='kubectl'
alias kube1='kubectl --kubeconfig=~/src/service_accounts/kubernetes-keys/tab-production/config --cluster=k8s-tab-production.open-runways.com --context=k8s-tab-production.open-runways.com'
alias kubem='kubectl --cluster=minikube'

# The next line updates PATH for the Google Cloud SDK.
if [ -f ~/google-cloud-sdk/path.zsh.inc ]; then
  source ~/google-cloud-sdk/path.zsh.inc
fi

# The next line enables shell command completion for gcloud.
if [ -f ~/google-cloud-sdk/completion.zsh.inc ]; then
  source ~/google-cloud-sdk/completion.zsh.inc
fi
