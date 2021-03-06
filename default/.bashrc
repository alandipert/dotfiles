# -*- mode: sh;-*-

function where() {
  local HOSTNAME="$(uname -n)"
  echo "${USER}@${HOSTNAME}"
}

export PROMPT_COMMAND='history -a;echo -ne "\033]0;bash ${PWD}\007";USER_HOST=$(where);PWD_ABBREV=$(mkgo ~/.bash/abbrev_pwd.c);pwd>$HOME/.cwd'

export PS1="\[\033[38;5;82m\]\${USER_HOST}\[\033[00m\]\[\033[38;5;200m\]\${PWD_ABBREV}\[\033[38;5;228m\]➜\[\033[00m\] "
export PATH="${HOME}/.cabal/bin:${HOME}/.local/bin:/usr/local/bin:${PATH}"
export PATH="${HOME}/.bash:${PATH}"
export EDITOR="${HOME}/.bash/e"

mkdir -p $HOME/gocode
export GOPATH=$HOME/gocode
export PATH="${GOPATH}/bin:$PATH"

# improve history stuff
# https://sanctum.geek.nz/arabesque/better-bash-history/
shopt -s histappend
shopt -s cmdhist
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL=ignoreboth
export HISTIGNORE='ls:bg:fg:history'
export HISTTIMEFORMAT='%F %T '

# Searching in vis
export FZF_DEFAULT_COMMAND='(git ls-files -co --exclude-standard || rg --files) 2> /dev/null'

if [[ $(uname -s) == Darwin ]]; then
	export PATH="${HOME}/Library/Python/3.7/bin/:${PATH}"
fi

function gc() { # (user-reponame-str)
  local FROM="git@github.com:${1?}"
  local TO="$HOME/github/${1?}"
  if [ -d "$TO" ]; then
      echo "Already done!"
  else
    git clone "$FROM" "$TO"
  fi
  cd "$TO"
}

function .. { # "cd up" - move up $1 directories
  cd $(printf '../%0.s' $(seq -s ' ' 1 ${1:-1}))
}

function nth () {
  local idxs;
  idxs="$@"
  awk "{n=split(\"$idxs\",idxs,\" \");for(i=1;i<=n;i++){printf\$idxs[i];printf(i<n)?OFS:\"\n\"}}"
}

function nthrest () {
  awk "{$(seq -s '' -f '$%.f=' 1 $1)\"\"; print \$0}" | sed -e 's/^\s*//';
}

sr () {
  for agent in /tmp/ssh-*/agent.*; do
    export SSH_AUTH_SOCK=$agent
    if ssh-add -l 2>&1 > /dev/null; then
        echo Found working SSH Agent:
        ssh-add -l 
        return
    fi
  done
  echo Cannot find ssh agent - maybe you should reconnect and forward it?
}

trying() {
  while true; do $@; sleep 5; done
}

function source-env() {
  # Unset AWS vars
  unset $(env | grep ^AWS | sed -e 's$\(AWS_.*\)=.*$\1$' | paste -s -d' ' -)
  # Remove all env-specific functions
  unset $(typeset -F \
              |cut -d' ' -f3\
              |egrep -i $(find $HOME/.bash/envs -type f -name '*.sh.gpg' -exec basename {} ';'\
                              |while read f; do echo ^${f%.sh.gpg}_; done\
                              |paste -s -d'|' -)\
              |paste -s -d' ' -)
  source <(GPG_TTY=$(tty) gpg --use-agent -d $HOME/.bash/envs/$1.sh.gpg)
}

source "${HOME}/.bash/alias.sh"
source "${HOME}/.bash/completion.sh"

[[ -e "${HOME}/.localrc" ]] && source "${HOME}/.localrc"

ssh-add ~/.ssh/id_rsa &>/dev/null

export NVM_DIR="/home/alan/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

complete -C '/usr/local/bin/aws_completer' aws

erbenv() {
  export PATH="$HOME/.rbenv/bin:$PATH"
  $(which rbenv) && eval "$(rbenv init -)"
}

if [[ $(uname -s) == "Darwin" ]]; then
	#list available jdks
	alias jdks="/usr/libexec/java_home -V"
	# jdk version switching - e.g. `jdk 6` will switch to version 1.6
	function jdk() {
	  echo "Switching java version $1";

	  requestedVersion=$1
	  oldStyleVersion=8
	  # Set the version
	  if [ $requestedVersion -gt $oldStyleVersion ]; then
	    export JAVA_HOME=$(/usr/libexec/java_home -v $1);
	  else
	    export JAVA_HOME=`/usr/libexec/java_home -v 1.$1`;
	  fi

	  echo "Setting JAVA_HOME=$JAVA_HOME"

	  which java
	  java -version;
	}
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[[ -f "${HOME}/.cwd" ]] && cd "$(< ${HOME}/.cwd)"
