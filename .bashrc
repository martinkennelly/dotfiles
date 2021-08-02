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
