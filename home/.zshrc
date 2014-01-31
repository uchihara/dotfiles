#/bin/zsh

# for zsh
autoload -U compinit
compinit

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
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

zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-colors ""
WORDCHARS=${WORDCHARS:s,/,,}

alias ls='ls -FCG --color=auto'
alias java='java -Dfile.encoding=UTF-8'
alias javac='javac -encoding UTF-8 -J-Dfile.encoding=UTF-8'
alias s3cmd='s3cmd --encoding=UTF-8'
alias grep='grep -I'
alias fgrep='fgrep -I'
alias egrep='egrep -I'
alias -g G='|grep'
alias -g L='|less'
alias -g LR='|less -R'
alias -g J='|~/tmp/json.php'
alias -g RJ='|ruby -rjson -e"puts JSON.pretty_generate(JSON.parse(gets))"'
alias ssp='ssh proxy.sc'
alias sspj='ssh proxyjp.sc'
alias sccons='(cd ~/src/webapp/tonchidot/console/bin; php sekaicamera-console.php)'
alias rspec='bundle exec rspec'
alias cap='bundle exec cap'
alias rails='bundle exec rails'
alias rake='bundle exec rake'
alias unicorn_rails='bundle exec unicorn_rails'
#alias god='bundle exec god'
alias clear2="echo -e '\026\033c'"

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

PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin; export PATH
MANPATH=/usr/local/share/man:/usr/share/man; export MANPATH
LIBRARY_PATH=/usrlocal/lib:/usr/lib; export LIBRARY_PATH
C_INCLUDE_PATH=/usr/local/include:/usr/include; export C_INCLUDE_PATH
CPLUS_INCLUDE_PATH=/usr/local/include:/usr/include; export CPLUS_INCLUDE_PATH
if [ -x /usr/bin/ccache ]; then
	CC='/usr/bin/ccache gcc'; export CC
	CXX='/usr/bin/ccache g++'; export CXX
fi

GOROOT=~/go; export GOROOT
PATH=$PATH:~/go/bin; export PATH

PATH=$PATH:~/Library/Developer/android-sdk/tools; export PATH
PATH=$PATH:~/Library/Developer/android-sdk/platform-tools; export PATH
ANDROIDNDK_HOME=~/Library/Developer/android-ndk; export ANDROIDNDK_HOME
PATH=$PATH:$ANDROIDNDK_HOME; export PATH

EDITOR=vim; export EDITOR
LESS=-R; export LESS


# for amazon ec2
if [ -d /usr/lib/jvm/default-java ]; then
	JAVA_HOME=/usr/lib/jvm/default-java; export JAVA_HOME
	EC2_HOME=/usr/local/ec2-api-tools-1.3-62308; export EC2_HOME
	EC2_PRIVATE_KEY=~/Documents/pk-PQWSL3XGN5XN6M2EWMXWRTQH5IHEFGOW.pem; export EC2_PRIVATE_KEY
	EC2_CERT=~/Documents/cert-PQWSL3XGN5XN6M2EWMXWRTQH5IHEFGOW.pem; export EC2_CERT
fi

if [ `uname` = Darwin ]; then

export JAVA_HOME="$(/usr/libexec/java_home)"
#export EC2_PRIVATE_KEY="$(/bin/ls $HOME/.ec2/pk-*.pem)"
#export EC2_CERT="$(/bin/ls $HOME/.ec2/cert-*.pem)"
export EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.5.2.5/jars"

#JAVA_HOME=/Library/Java/Home; export JAVA_HOME
#EC2_HOME=/usr/local/ec2-api-tools-1.5.0.1-2011.11.30; export EC2_HOME
EC2_PRIVATE_KEY=~/Documents/pk-PQWSL3XGN5XN6M2EWMXWRTQH5IHEFGOW.pem; export EC2_PRIVATE_KEY
EC2_CERT=~/Documents/cert-PQWSL3XGN5XN6M2EWMXWRTQH5IHEFGOW.pem; export EC2_CERT
AWS_ELB_HOME=/usr/local/ElasticLoadBalancing-1.0.10.0; export AWS_ELB_HOME
AWS_IAM_HOME=/usr/local/IAMCli-1.4.0; export AWS_IAM_HOME
fi

PATH=$PATH:$EC2_HOME/bin:$AWS_ELB_HOME/bin:$AWS_IAM_HOME/bin; export PATH
AWS_CREDENTIAL_FILE=~/.aws-cred; export AWS_CREDENTIAL_FILE
function ec2() {
	if [ $# -ne 1 ]; then
		echo "usage: ec2 <keyword>"
		return
	fi
	ls -1 $EC2_HOME/bin | egrep -v '\.cmd$' G $1
}

#
PATH=~/bin:$PATH

# Load RVM into a shell session *as a function*
[[ -s ~/.rvm/scripts/rvm ]] && source ~/.rvm/scripts/rvm && rvm use default >/dev/null
[[ -s ~/.nvm/nvm.sh ]] && source ~/.nvm/nvm.sh
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

#export RUBY_GC_MALLOC_LIMIT=100000000
export RUBY_GC_MALLOC_LIMIT=600000000
export RUBY_HEAP_MIN_SLOTS=1000000
#export RUBY_FREE_MIN=2000000
export RUBY_FREE_MIN=1000000

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:/usr/local/share/npm/bin
