# 256 color support?
#
colors=`tput colors`

# Set the prompt.
#
if [ $colors -ge 256 ]; then
    PS1="$(tput setaf 208)$ $(tput sgr0)"
    PS2="$(tput setaf 208)> $(tput sgr0)"
else
    PS1='$ '
    PS2='> '
fi

# Emacs.
#
if [[ -n `which emacs` ]]; then
    alias emacs='emacs -nw'
    export EDITOR='emacs -nw'
fi

# Aliases
#
alias ll='ls -l' 
alias la='ls -la'
