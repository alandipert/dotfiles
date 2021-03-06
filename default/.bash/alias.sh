alias g=git
alias st='stterm -f terminus:pixelsize=16:antialias=false:autohint=false'
alias sum="perl -nle '\$sum += \$_ } END { print \$sum'"

if [[ $(uname -s) == "Darwin" ]]; then
  alias ll='gls --color=auto -Flh'
	alias ll='gls -Flah --color=auto --group-directories-first'
else
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
  alias ll='ls -Flah --color=auto --group-directories-first'
fi
