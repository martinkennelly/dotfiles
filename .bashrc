# ~/.bashrc: executed by bash(1) for non-login shells.
export HISTCONTROL=ignoredups
export HISTSIZE=9999
export HISTFILESIZE=99999
shopt -s histappend

#ALIAS
export LS_OPTIONS='-F --color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA --group-directories-first'
alias n=nano
alias b='vim ~/.bashrc'
alias tree='tree -C'
alias lll='tree'
alias filecount='find . -type f | wc -l'
alias sudo="sudo "
alias clr=clear
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias vi=vim
alias edit='vim'
alias ping='ping -c 5'
alias ports='netstat -tulanp'
alias wget='wget -c'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias meminfo='free -m -t -l'
alias psmem='ps auxf | sort -nr -k 4 | head -10'
alias pscpu='ps auxf | sort -nr -k 3 | head -10'
alias updateycm='cd ~/.vim/bundle/YouCompleteMe && git pull && git pull --recurse-submodules && ./install.py --clang-completer'

#FUNCTIONS
mk(){ mkdir "$@" && cd "$@"; }
c(){ cd "$@" && ls; }
linux_update()
{
	sudo apt-get update && \
	sudo apt-get -yy upgrade && \
	sudo apt-get -yy autoremove && \
	sudo apt-get clean;
}

findfunction() {
  find 2>/dev/null -L -iname "*$1*" ${@:2}
}

man() {
    env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;38;5;74m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[46;30m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[04;38;5;146m' \
    man "$@"
}

fsdevice () {
    SCRIPT_USER=$USER
    MACHINE="NONE"
    MOUNT_POINT="$HOME/device"
    PORT=22
    # shift
    while [[ $# -gt 0 ]] ; do
        key="$1"
        # echo "#processing: $key"
        case $key in
            -u|--user)
                SCRIPT_USER="$2"
                shift # past argument
                ;;
            -m|--mount)
                MOUNT_POINT="$2"
                shift # past argument
                ;;
            -p|--port)
                PORT="$2"
                shift # past argument
                ;;
            *)
                MACHINE=$1
                ;;
        esac
        shift # past argument or value
    done
    if [ $MACHINE = "NONE" ] ; then echo "missing target machine" ; return 1 ; fi
    mkdir -p $MOUNT_POINT 2>/dev/null
    # echo ARGS: $MACHINE , $MOUNT_POINT , $SCRIPT_USER , $PORT
    sudo fusermount -zu $MOUNT_POINT
    sudo sshfs ${SCRIPT_USER}@${MACHINE}:/ -p $PORT $MOUNT_POINT -C -o allow_other
    echo "Mounted ${SCRIPT_USER}@${MACHINE}:/ at $MOUNT_POINT"
}

bind -m vi '"\e[5~":"\e[A"'
bind -m vi-insert '"\e[5~":"\e[A"'
bind -m vi '"\e[6~":"\e[B"'
bind -m vi-insert '"\e[6~":"\e[B"'
