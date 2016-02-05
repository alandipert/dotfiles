adzerk_env() {
  eval "$(gpg -d $HOME/Dropbox/dotfiles/.adzerk.asc)"
  export AWS_ACCESS_KEY=$ADZERK_AWS_ACCESS_KEY
  export AWS_SECRET_KEY=$ADZERK_AWS_SECRET_KEY
}
