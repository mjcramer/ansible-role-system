#!/bin/bash

if [ "$BASH_SOURCE" = "$0" ]; then
    echo "This script can only be sourced."
    exit 1
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

##
## GENERAL OPTIONS
##

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Update window size after every command
shopt -s checkwinsize

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

##
## HISTORY OPTIONS 
##

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Useful timestamp format
HISTTIMEFORMAT='%F %T '

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Enable incremental history search with up/down arrows (also Readline goodness)
# Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

##
## TAB-COMPLETION (Readline bindings) 
##

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

##
## DIRECTORY NAVIGATION 
##

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null

# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null

# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
CDPATH="."

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
shopt -s cdable_vars

# Automatically trim long paths in the prompt (requires Bash 4.x)
export PROMPT_DIRTRIM=2

# Set the title and command prompts
case $TERM in
    screen)
        export PROMPT_COMMAND='echo -ne "\033k$(basename $PWD)\033\\"'
        ;;
    *)
        hostname=`hostname -s`
        export PROMPT_COMMAND='echo -ne "\033]0;[${hostname:0:7}] $(basename $PWD)\007"'
        ;;
esac


reset='\033[00m'

# Foreground
f_blk='\033[0;30m' # Black - Regular
f_red='\033[0;31m' # Red - Regular
f_grn='\033[0;32m' # Green - Regular
f_ylw='\033[0;33m' # Yellow - Regular
f_blu='\033[0;34m' # Blue - Regular
f_mag='\033[0;35m' # Magenta - Regular
f_cyn='\033[0;36m' # Cyan - Regular
f_wht='\033[0;37m' # White - Regular
f_blk_b='\033[1;30m' # Black - Bold
f_red_b='\033[1;31m' # Red - Bold
f_grn_b='\033[1;32m' # Green - Bold
f_ylw_b='\033[1;33m' # Yellow - Bold
f_blu_b='\033[1;34m' # Blue - Bold
f_mag_b='\033[1;35m' # Purple - Bold
f_cyn_b='\033[1;36m' # Cyan - Bold
f_wht_b='\033[1;37m' # White - Bold
f_blk_i='\033[3;30m' # Black - Italic
f_red_i='\033[3;31m' # Red - Italic
f_grn_i='\033[3;32m' # Green - Italic
f_ylw_i='\033[3;33m' # Yellow - Italic
f_blu_i='\033[3;34m' # Blue - Italic
f_pur_i='\033[3;35m' # Purple - Italic
f_cyn_i='\033[3;36m' # Cyan - Italic
f_wht_i='\033[3;37m' # White - Italic
f_blk_u='\033[4;30m' # Black - Underline
f_red_u='\033[4;31m' # Red - Underline
f_grn_u='\033[4;32m' # Green - Underline
f_ylw_u='\033[4;33m' # Yellow - Underline
f_blu_u='\033[4;34m' # Blue - Underline
f_pur_u='\033[4;35m' # Purple - Underline
f_cyn_u='\033[4;36m' # Cyan - Underline
f_wht_u='\033[4;37m' # White - Underline

# Background
b_blk='\033[40m'   # Black - Background
b_red='\033[41m'   # Red
b_grn='\033[42m'   # Green
b_ylw='\033[43m'   # Yellow
b_blu='\033[44m'   # Blue
b_pur='\033[45m'   # Purple
b_cyn='\033[46m'   # Cyan
b_wht='\033[47m'   # White
# Primary prompt
PS1='\['$f_wht_i'\]\D{%H:%M:%S}\['$reset'\] \['$f_grn_b'\](\u@\h)\['$reset'\] \['$f_mag_b'\][\w]\['$reset'\] '
# Prompt for incomplete input (like when you forget closing quotes)
PS2='\['$f_wht_i'\]\D{%H:%M:%S}\['$reset'\] \['$f_blk'\]\['$b_blk'\](\u@\h) [\w]\['$reset'\] '
# Prompt for 'select' command
#PS3=
# Prompt for execution traces (default '+' sign)
#PS4=

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# colored man pages
# mb - Start blinking
# md - Start bold mode
# me - End all mode like so, us, mb, md and mr
# so - Start standout mode
# se - End standout mode
# us - Start underlining
# ue - End underlining
man() {
    env \
        LESS_TERMCAP_mb=$(printf "$f_red") \
        LESS_TERMCAP_md=$(printf "$f_cyn_b") \
        LESS_TERMCAP_us=$(printf "$f_grn_i") \
        LESS_TERMCAP_so=$(printf "$b_red$f_ylw") \
        LESS_TERMCAP_me=$(printf "$reset") \
        LESS_TERMCAP_se=$(printf "$reset") \
        LESS_TERMCAP_ue=$(printf "$reset") \
        man "$@"
}

alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias less='less -r'
alias mkdir='mkdir -pv'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias search='grep -IRHn --color=auto'
alias h='history'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
alias svi='sudo vi'
alias ping='ping -c 5'
alias pingfast='ping -c 100 -s.2'

alias ls='ls -F --color=auto'
alias ll='ls -lF --color=auto'
alias lla='ls -alF --color=auto'
alias la='ls -aF --color=auto'
alias l='ls -CF --color=auto'
alias l.='ls -d --color=auto .*'
alias listening='ss -tlpn'
alias vi=vim

alias meminfo='free -m -l -t'
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
alias cpuinfo='lscpu'
alias pyjson='python -m json.tool'

# Add current directory to path
export PATH=$PATH:.
