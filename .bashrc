#
# ~/.bashrc
#

# If not running interactively
[[ $- != *i* ]] && return

# Default ls to use colors
alias ls='ls --color=auto'

# Show long listing of all except ".."
alias ll='ls -lav --ignore=..'

# Show long listing but no hidden dotfiles except "."
alias l='ls -lav --ignore=.?*'

# Limits recursive function depth
[[ -z "$FUNCNEST" ]] && export FUNCNEST=100

# Up and down arrows to search history w/ partial completion
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'


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

PS1='$(gradient "153,193,241" "98,160,234" "\u@\h:\w $ ")'

export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
