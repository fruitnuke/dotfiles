# 256 color support?
#
case $TERM in
    *-256color) color=yes;;
esac

# Set the prompt.
#
if [ $color = yes ]; then
    PS1='\[\033[38;5;208m\]\$ \[\033[00m\]'
    PS2='\[\033[38;5;208m\]\> \[\033[00m\]'
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
