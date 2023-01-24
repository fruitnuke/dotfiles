# Commands to be executed when an interactive shell is started

# Set prompt here rather than in zprofile as, although both are run
# when starting a new macos terminal session, it seems like zprofile
# is run first, then zsh sets the default prompt, then runs zshrc. So,
# it doesn't work, if set in zprofile.
#
PROMPT="%F{208}$ %f"
