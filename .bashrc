#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.welcome_screen ]] && . ~/.welcome_screen

_set_liveuser_PS1() {
    PS1='[\u@\h \W]\$ '
    if [ "$(whoami)" = "liveuser" ] ; then
        local iso_version="$(grep ^VERSION= /usr/lib/endeavouros-release 2>/dev/null | cut -d '=' -f 2)"
        if [ -n "$iso_version" ] ; then
            local prefix="eos-"
            local iso_info="$prefix$iso_version"
            PS1="[\u@$iso_info \W]\$ "
        fi
    fi
}
_set_liveuser_PS1
unset -f _set_liveuser_PS1

ShowInstallerIsoInfo() {
    local file=/usr/lib/endeavouros-release
    if [ -r $file ] ; then
        cat $file
    else
        echo "Sorry, installer ISO info is not available." >&2
    fi
}


alias ls='ls --color=auto'
alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."

[[ "$(whoami)" = "root" ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100          # limits recursive functions, see 'man bash'

## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

################################################################################
## Some generally useful functions.
## Consider uncommenting aliases below to start using these functions.
##
## October 2021: removed many obsolete functions. If you still need them, please look at
## https://github.com/EndeavourOS-archive/EndeavourOS-archiso/raw/master/airootfs/etc/skel/.bashrc

_open_files_for_editing() {
    # Open any given document file(s) for editing (or just viewing).
    # Note1:
    #    - Do not use for executable files!
    # Note2:
    #    - Uses 'mime' bindings, so you may need to use
    #      e.g. a file manager to make proper file bindings.

    if [ -x /usr/bin/exo-open ] ; then
        echo "exo-open $@" >&2
        setsid exo-open "$@" >& /dev/null
        return
    fi
    if [ -x /usr/bin/xdg-open ] ; then
        for file in "$@" ; do
            echo "xdg-open $file" >&2
            setsid xdg-open "$file" >& /dev/null
        done
        return
    fi

    echo "$FUNCNAME: package 'xdg-utils' or 'exo' is required." >&2
}

#------------------------------------------------------------

## Aliases for the functions above.
## Uncomment an alias if you want to use it.
##

# alias ef='_open_files_for_editing'     # 'ef' opens given file(s) for editing
# alias pacdiff=eos-pacdiff
################################################################################

rgb() {
    printf "\001\033[38;2;%d;%d;%dm\002" "$1" "$2" "$3"
}

lerp_color() {
    local r1=$1
    local g1=$2
    local b1=$3
    local r2=$4
    local g2=$5
    local b2=$6
    local factor=$7

    local r=$(( r1 + (r2 - r1) * factor / 100 ))
    local g=$(( g1 + (g2 - g1) * factor / 100 ))
    local b=$(( b1 + (b2 - b1) * factor / 100 ))

    rgb $r $g $b
}

gradient() {
    local color1=(${1//,/ })
    local color2=(${2//,/ })
    local text=$3
    local length=${#text}
    local gradient=""
    local factor=0

    for (( i=0; i<$length; i++ )); do
        factor=$(( 100 * i / (length - 1) ))
        gradient+=$(lerp_color "${color1[0]}" "${color1[1]}" "${color1[2]}" "${color2[0]}" "${color2[1]}" "${color2[2]}" "$factor")${text:$i:1}
    done

    gradient+="\001\033[0m\002"

    echo -ne "$gradient"
}

PS1='$(gradient "64,224,208" "0,128,128" "\u@\h:\w $ ")'
