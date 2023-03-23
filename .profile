if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

PS1='\[\033[1;34m\]\h.lan \w\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]'
MOZ_ENABLE_WAYLAND=1
