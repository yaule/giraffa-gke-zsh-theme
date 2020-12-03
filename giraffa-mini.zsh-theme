# fino-time.zsh-theme

# Use with a dark background and 256-color terminal!
# Meant for people with RVM and git. Tested only on OS X 10.7.

# You can set your computer name in the ~/.box-name file if you want.

# Borrowing shamelessly from these oh-my-zsh themes:
#   bira
#   robbyrussell
#
# Also borrowing from http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/
# from fino-time


function prompt_char() {
    git branch >/dev/null 2>/dev/null && echo '⠠⠵' && return
    echo '○'
}

function box_name() {
    [ -f ~/.box-name ] && cat ~/.box-name || echo ${SHORT_HOST:-$HOST}
}
function prompt_status() {
    RETVAL=$?
    local symbols
    symbols=()
    [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}\u2718"
    [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}\u26a1"
    [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}\u2699"

    [[ -n "$symbols" ]] && echo "$symbols%{$reset_color%} "
}

# exec time
function displaytime() {
    local T=$1
    local D=$((T / 60 / 60 / 24))
    local H=$((T / 60 / 60 % 24))
    local M=$((T / 60 % 60))
    local S=$((T % 60))
    [[ $D > 0 ]] && printf '%dd' $D
    [[ $H > 0 ]] && printf '%dh' $H
    [[ $M > 0 ]] && printf '%dm' $M
    printf '%ds' $S
}

function preexec() {
    cmd_timestamp=$(date +%s)
}

function precmd() {
    local stop=$(date +%s)
    local start=${cmd_timestamp:-$stop}
    let BULLETTRAIN_last_exec_duration=$stop-$start
    cmd_timestamp=''
}

function prompt_cmd_exec_time() {

    if [ ! -n "${BULLETTRAIN_EXEC_TIME_ELAPSED+1}" ]; then
        BULLETTRAIN_EXEC_TIME_ELAPSED=5
    fi
    if [ ! -n "${BULLETTRAIN_EXEC_TIME_BG+1}" ]; then
        BULLETTRAIN_EXEC_TIME_BG=yellow
    fi
    if [ ! -n "${BULLETTRAIN_EXEC_TIME_FG+1}" ]; then
        BULLETTRAIN_EXEC_TIME_FG=black
    fi

    [ $BULLETTRAIN_last_exec_duration -gt $BULLETTRAIN_EXEC_TIME_ELAPSED ] && echo "%{$FG[202]%}$(displaytime $BULLETTRAIN_last_exec_duration)%{$reset_color%}"
}

PROMPT="╭─\$(prompt_status)%{$FG[040]%}%n%{$reset_color%} %{$FG[239]%}at%{$reset_color%} %{$FG[033]%}$(box_name)%{$reset_color%} %{$FG[239]%}in%{$reset_color%} %{$terminfo[bold]$FG[226]%}%~%{$reset_color%}\$(git_prompt_info) %D - %* \$(prompt_cmd_exec_time)
╰─\$(prompt_char) "

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$FG[239]%}on%{$reset_color%} %{$fg[255]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[202]%}✘✘✘"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[040]%}✔"
