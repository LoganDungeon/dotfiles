#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# set mail directory
export MAIL="$HOME/.mail/privat/INBOX"

export PATH=$PATH:$HOME/.scripts:$HOME/.scripts/polybar
export EDITOR="vim"
export TERMINAL="urxvt"
export BROWSER="firefox"
#export BROWSER="qutebrowser"

if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep i3 || startx
fi
