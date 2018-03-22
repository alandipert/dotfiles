_ssh()
{
  local cur prev opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  opts=$(grep '^Host' ~/.ssh/config | awk '{print $2}')

  COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
  return 0
}
complete -F _ssh ssh
