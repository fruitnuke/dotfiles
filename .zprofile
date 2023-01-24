# Commands to be executed when a login shell is started.

# Emacs conveniences.
#
if [[ -n `which emacs` ]]; then
    alias emacs='emacs -nw'
    export EDITOR='emacs -nw'
fi

# Aliases.
#
alias ll='ls -l' 
alias la='ls -la'

# Set PATH, MANPATH, etc., for Homebrew.
#
eval "$(/opt/homebrew/bin/brew shellenv)"
