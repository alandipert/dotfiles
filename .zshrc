# -----------------------------------------------
# zsh .zshrc
# -----------------------------------------------

# -----------------------------------------------
# Set up the Environment
# -----------------------------------------------

TERM=screen
EDITOR=vim
PAGER=less
RSYNC_RSH=/usr/bin/ssh
FIGNORE='.o:.out:~'
DISPLAY=:0.0
LS_COLORS='no=00:fi=00:di=00;36:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.bz2=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.sit=01;31:*.hqx=01;31:*.jpg=01;35:*.png=01;35:*.gif=01;35:*.bmp=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mpg=01;35:*.avi=01;35:*.mov=01;35:*.app=01;33:*.c=00;33:*.php=00;33:*.pl=00;33:*.cgi=00;33:'
COLORTERM=yes

# -----------------------------------------------
# OS X specific - path_helper builds paths for you
# -----------------------------------------------
if [ -x /usr/libexec/path_helper ]; then
  # we're on OS X
	eval `/usr/libexec/path_helper -s`
  # MacPorts
  PATH=/opt/local/bin:/opt/local/sbin:$PATH
  MANPATH=MANPATH=/opt/local/share/man:$MANPATH
else
  # we're on something else
  PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin
fi

# My stuff
PATH=/Users/alan/local/bin:$PATH

# Google Java bullshit
PATH=/Users/alan/local/gwt-mac-1.7.0:/Users/alan/local/appengine-java-sdk-1.2.1/bin:$PATH

HISTFILE=~/.zshhistory
HISTSIZE=3000
SAVEHIST=3000
MAILCHECK=0

export TERM EDITOR PAGER RSYNC_RSH CVSROOT FIGNORE DISPLAY LS_COLORS NNTPSERVER COLORTERM PATH MANPATH HISTFILE HISTSIZE SAVEHIST MAILCHECK

# -----------------------------------------------
# Load zsh modules
# -----------------------------------------------

# compinit initializes various advanced completions for zsh
autoload -U compinit && compinit 
# zmv is a batch file rename tool; e.g. zmv '(*).text' '$1.txt'
autoload zmv

# -----------------------------------------------
# Set up zsh autocompletions
# -----------------------------------------------

# case-insensitive tab completion for filenames (useful on Mac OS X)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# General completion technique
zstyle ':completion:*' completer _complete _correct _approximate _prefix
zstyle ':completion:*' completer _complete _prefix
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:predict:*' completer _complete

# Completion caching
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

# Expand partial paths
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'

# Don't complete backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

# Separate matches into groups
zstyle ':completion:*:matches' group 'yes'

# Describe each match group.
zstyle ':completion:*:descriptions' format "%B---- %d%b"

# Messages/warnings format
zstyle ':completion:*:messages' format '%B%U---- %d%u%b' 
zstyle ':completion:*:warnings' format '%B%U---- no match for: %d%u%b'
 
# Describe options in full
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# -----------------------------------------------
# Set up completion for hostnames
# -----------------------------------------------

if [[ "$ZSH_VERSION_TYPE" == 'new' ]]; then
  : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}}
else
  # Older versions don't like the above cruft
  _etc_hosts=()
fi

hosts=(
	"$_etc_hosts[@]"

	localhost
	#Add favourite hosts here, and zsh will autocomplete them
)

zstyle ':completion:*' hosts $hosts

my_accounts=(
	root@localhost
  alan@ubergibson.com
  alan@droplink.me
	#Add ssh hosts here, and zsh will autocomplete them
)

zstyle ':completion:*:my-accounts' users-hosts $my_accounts

# -----------------------------------------------
# Set zsh options
# -----------------------------------------------

setopt \
	no_beep \
	correct \
	auto_list \
	complete_in_word \
	auto_pushd \
	complete_aliases \
	extended_glob \
	zle

# -----------------------------------------------
# Shell Aliases
# -----------------------------------------------

## Command Aliases
alias x=exit
alias c=clear
alias s=screen
alias r='screen -R'
alias vi='vim'
alias sls='screen -ls'
alias zrc='vim ~/.zshrc'
alias e='smartextract'
alias sl="ls"
alias o='open'

## Pipe Aliases (Global)
alias -g L='|less'
alias -g G='|grep'
alias -g T='|tail'
alias -g H='|head'
alias -g W='|wc -l'
alias -g S='|sort'

## Shell Aliases

# Servers
alias u="ssh ubergibson.com"
alias z1="ssh droplink.me"

## Special Root Aliases
[ $UID = 0 ] && \
	alias m='make' && \
	alias mi='make install' && \
	alias rm='rm -i' && \
	alias mv='mv -i' && \
	alias cp='cp -i'

# -----------------------------------------------
#  User-defined Functions
# -----------------------------------------------

# Usage: smartextract <file>
# Description: extracts archived files / mounts disk images
# Note: .dmg/hdiutil is Mac OS X-specific.
smartextract () {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)  tar -jxvf $1        ;;
            *.tar.gz)   tar -zxvf $1        ;;
            *.bz2)      bunzip2 $1          ;;
            *.dmg)      hdiutil mount $1    ;;
            *.gz)       gunzip $1           ;;
            *.tar)      tar -xvf $1         ;;
            *.tbz2)     tar -jxvf $1        ;;
            *.tgz)      tar -zxvf $1        ;;
            *.zip)      unzip $1            ;;
            *.Z)        uncompress $1       ;;
            *)          echo "'$1' cannot be extracted/mounted via smartextract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Usage: cdu <number>
# Description: Moves up <number> parent directories, or the immediate parent if none specified.
cdu () {
  if [ -z $1 ]; then
    num=1
  else
    num=$1
  fi
  while [ $num -gt "0" ]; do
    cd ..
    num=$(( $num - 1 ))
  done
  pwd
}

# Usage: resetmac 
# Description: Resets my laptop's MAC address to the default.
resetmac () { # reset wifi MAC 
 sudo ifconfig en1 lladdr "00:17:f2:47:0b:27"
}

# Set up prompt, based on walters
PROMPT='%B%(?..[%?] )%b%n@%m> '
RPROMPT="%{$fg_no_bold[${:-black}]%}%~%{$reset_color%}"
export PROMPT RPROMPT

export CLICOLOR=0
export LSCOLORS=CxFxExDxBxegedabagacad
#
# resty - A tiny command line REST interface for bash.
#
# Fork me on github:
#   http://github.com/micha/resty
#
# Author:
#   Micha Niskin <micha@thinkminimo.com>
#   Copyright 2009, no rights reserved.
#

function resty() {
  local conf="${HOME}/.restyrc"
  local host=`cat "$conf" 2>/dev/null`
  local method="$1";          [[ $# > 0 ]] && shift
  local uri="$1";             [[ $# > 0 ]] && shift;
  local h2t=html2text;        which $h2t >/dev/null || h2t=cat
  local accp="Accept: application/json"
  local opt dat res ret out err verbose i

  [ -z "$method" ] && cat "$conf" 2>/dev/null && return

  for i in "$@"; do
    ([ "$i" == "--verbose" ] || echo "$i" | grep -q '^-[a-zA-Z]*v[a-zA-Z]*$') \
      && verbose="yes"
  done

  uri="${host//\*/$uri}"

  case "$method" in
    GET|DELETE|POST|PUT)
      [ "${method#P}" != "$method" ] && opt="--data-binary" && dat="$1" \
        && [[ $# > 0 ]] && shift
      res=$((((curl -sLv -H "$accp" $opt "$dat" -X $method "$@" "$uri" \
        |sed 's/^/OUT /' && echo) 3>&2 2>&1 1>&3) \
        |sed 's/^/ERR /' && echo) 2>&1)
      out=$(echo "$res" |sed '/^OUT /s/^....//p; d')
      err=$(echo "$res" |sed '/^ERR /s/^....//p; d')
      ret=$(echo "$err" |sed \
        '/^.*HTTP\/1\.[01] [0-9][0-9][0-9]/s/.*\([0-9]\)[0-9][0-9].*/\1/p; d' \
        | tail -n1)
      [ -n "$err" -a -n "$verbose" ] && echo "$err" 1>&2
      if [ "$ret" != "2" ]; then
        [ -n "$out" ] && echo "$out" | $h2t 1>&2
        return $ret
      else
        [ -n "$out" ] && echo "$out"
      fi
      ;;
    http://*|https://*)
      echo "$method" |grep -q '\*' || method="${method}*"
      (echo "$method" |tee "$conf") |cat 1>&2
      ;;
    *)
      resty "http://$method"
      ;;
  esac
}

function GET() {
  resty GET "$@"
}

function POST() {
  resty POST "$@"
}

function PUT() {
  resty PUT "$@"
}

function DELETE() {
  resty DELETE "$@"
}
