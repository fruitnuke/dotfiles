# Set the prompt.
#
PS1='$ '
PS2='> '

# Emacs.
#
if [[ -n `which emacs` ]]; then
    alias emacs='emacs -nw'
    export EDITOR=emacs
fi

# Aliases
#
alias ll='ls -l' 
alias la='ls -la'
