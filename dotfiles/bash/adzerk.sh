adzerk_env() {
  eval "$(gpg -d $HOME/Dropbox/dotfiles/.adzerk.asc)"
}


[[ -z "${ADZERK_SCRIPTS_PATH}" ]] && \
  export ADZERK_SCRIPTS_PATH="${HOME}/github/adzerk/cli-tools/scripts"
export PATH="${HOME}/github/adzerk/cli-tools:$PATH"
