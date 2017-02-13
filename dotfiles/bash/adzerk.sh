GPG_TTY=$(tty)
export GPG_TTY
aenv() {
  eval "$(gpg2 --use-agent -d $HOME/Dropbox/dotfiles/.adzerk.asc)"
}


[[ -z "${ADZERK_SCRIPTS_PATH}" ]] && \
  export ADZERK_SCRIPTS_PATH="${HOME}/github/adzerk/cli-tools/scripts"
export PATH="${HOME}/github/adzerk/cli-tools:$PATH"
