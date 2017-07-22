
case $(uname -s) in
    Darwin) export platform="mac";;
    Linux)  export platform="linux";;
esac

if [ $platform == "mac" ];
then
   # On macOS Terminal.app runs (interactive) login shells, so ensure
   # we run .bashrc as well.
   [[ -e ~/.bashrc  ]] && source ~/.bashrc
fi

