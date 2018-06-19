# vim: filetype=sh
stty -ixon

# History Size, ignore duplicates
export HISTFILESIZE=10000
export HISTSIZE=5000
HISTCONTROL=ignoreboth

# only apped changes and live updating bash_history
PROMPT_COMMAND='history -a'
# If set, Bash checks window size after each command and updates the calues of LINES and COLUMNS
shopt -s checkwinsize
# Allows you to cd into directory merely by typing the directory name.
shopt -s autocd
# If set, the Hstory list is appended to the file named by the value of the HISTFILE variable when the shell exits, rather than overwriting the file
shopt -s histappend
# If set, bash attempts to save all lines of a multi-line command in the same history entry
shopt -s cmdhist

# For directory and config shortcuts:
[ -e ~/.bash_shortcuts ] && source ~/.bash_shortcuts

# Setting Bash prompt. Capitalizes username and host if root user (my root user uses this same config file).
if [ "$EUID" -ne 0 ]
	then export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
	else export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]ROOT\[$(tput setaf 2)\]@\[$(tput setaf 4)\]$(hostname | awk '{print toupper($0)}') \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
fi

#Generic shortcuts:
alias music="ncmpcpp"
alias clock="ncmpcpp -s clock"
alias visualizer="ncmpcpp -s visualizer"
alias news="newsboat"
alias email="neomutt"
alias files="ranger"
alias audio="ncpamixer"
alias calender="calcurse"
alias bat="acpi"
alias getmail="offlineimap && notmuch new"
alias gm="offlineimap && notmuch new"
alias lyrics="bash ~/.scripts/getlyrics spotify"
alias cols="bash ~/.scripts/color.sh"
alias todo="cat ~/Documents/todo.md"
alias server="python -m http.server 8000"
alias telegram="telegram-desktop"
alias bt="bluetoothctl"

o() { xdg-open $@ & }

tpad()
{
	enabled=$(xinput --list-props 'ETPS/2 Elantech Touchpad' | sed -n 'y/\t/ /; s/^ *Device Enabled ([0-9]*): *//p') 
	xinput --set-prop 'ETPS/2 Elantech Touchpad' 'Device Enabled' $((1-enabled))
}

# System Maintainence
alias progs="(pacman -Qet && pacman -Qm) | sort -u" # List programs I've installed
alias orphans="pacman -Qdt" # List orphan programs
alias pipupgr="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo pip install -U"
alias sdn="sudo shutdown now"
alias newnet="sudo systemctl restart NetworkManager" # Refresh wifi
alias nf="clear && neofetch" # Le Redditfetch
#Install an AUR package manually (for Parabola to get AUR access):
aurinstall() { curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/$1.tar.gz && tar -xvf $1.tar.gz && cd $1 && makepkg --noconfirm -si && cd .. && rm -rf $1 $1.tar.gz ;}
alias psref="gpg-connect-agent RELOADAGENT /bye" # Refresh gpg
alias mw="$HOME/.config/mutt/mutt-wizard.sh"

# Update functions
upgr()
{
	neofetch
	sudo pacman -Syyu --noconfirm
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		notify-send "$(figlet 'Upgrade Complete')"
	else
		notify-send "$(figlet 'Error')"
	fi
	}

aurupgr()
{
	neofetch;
	packer -Syu --auronly --noconfirm;
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		notify-send "$(figlet 'Upgrade Complete')"
	else
		notify-send "$(figlet 'Error')"
	fi
}

fupgr()
{
	neofetch;
	packer -Syu --auronly --noconfirm
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		sudo pacman -Syyu --noconfirm
		exitstatus=$?
		if [ $exitstatus = 0 ]; then
			notify-send "$(figlet 'Upgrade Complete')"
		else
			notify-send "$(figlet 'Error')"
		fi
	else
		notify-send "$(figlet 'Error')"
	fi
}

# Some aliases
alias pac="sudo pacman"
alias sv="sudo vim"
alias ra="ranger"
alias sra="sudo ranger"
alias ka="killall"
alias tr="transmission-remote"
alias mkdir="mkdir -pv"
alias rf="source ~/.bashrc"
alias ref="~/.scripts/shortcuts.sh && source ~/.bashrc" # Refresh shortcuts manually and reload bashrc
alias bars="bash ~/.config/polybar/launch.sh" # Run Polybar relaunch script
alias bw="wal -i ~/.config/wall.png" # Rerun pywal
weath() { curl wttr.in/$1 ;} # Check the weather (give city or leave blank).

# Adding color
alias ls='ls -hN --color=auto --group-directories-first'
alias ll='ls -lahN --color=auto --group-directories-first'
alias crep="grep --color=always" # Color grep - highlight desired sequence.
alias ccat="highlight --out-format=xterm256" #Color cat - print file with syntax highlighting.


# Internet
alias yt="youtube-dl --add-metadata -ic" # Download video link
alias yta="youtube-dl --add-metadata --embed-thumbnail --audio-format mp3 -xic" # Download only audio
alias YT="youtube-viewer"
alias ethspeed="speedometer -r enp3s0"
alias wifispeed="speedometer -r wlp2s0"
alias starwars="telnet towel.blinkenlights.nl"

# TeX
alias Txa="cp ~/Documents/LaTeX/article.tex"
alias Txs="cp ~/Documents/LaTeX/beamer.tex"
alias Txh="cp ~/Documents/LaTeX/handout.tex"
alias TC='texclear'

# Audio and Music
alias mute="pamixer -m"
alias unmute="pamixer -u"
alias vu="pamixer --allow-boost -i 5"
alias vd="pamixer --allow-boost -d 5"
alias pause="mpc toggle"
alias next="mpc next"
alias prev="mpc prev"
alias trupause="mpc pause"
alias beg="mpc seek 0%"
alias lilbak="mpc seek -10"
alias lilfor="mpc seek +10"
alias bigbak="mpc seek -120"
alias bigfor="mpc seek +120"

# bash startup stuff
#nf
echo "TODO:"
todo
