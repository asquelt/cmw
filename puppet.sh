# NOTE: This file is managed by Puppet; any changes you make will be erased.

parse_git_branch ()
{
    local GITDIR=`git rev-parse --show-toplevel 2>&1` # Get root directory of git repo
    if [[ "$GITDIR" != '/root' ]] # Don't show status of home directory repo
    then
        # Figure out the current branch, wrap in brackets and return it
        local BRANCH=`git branch --no-color 2>/dev/null | sed -n '/^\*/s/^\* //p'`
        if [ -n "$BRANCH" ]; then
            echo -e "[$BRANCH]"
        fi
    else
        echo ""
    fi
}

function git_color ()
{
    # Get the status of the repo and chose a color accordingly
    local STATUS=`git status 2>&1`
    if [[ "$STATUS" == *'Not a git repository'* ]]
    then
        echo ""
    else
        if [[ "$STATUS" != *'working directory clean'* ]]
        then
            # red if need to commit
            echo -e '\033[0;31m'
        else
            if [[ "$STATUS" == *'Your branch is ahead'* ]]
            then
                # yellow if need to push
                echo -e '\033[0;33m'
            else
                # else cyan
                echo -e '\033[0;36m'
            fi
        fi
    fi
}

if [ $UID -ne 0 ] ; then
    export PS1="\[\033[0;36mHint: Switch to root account to begin your quest.\033[0m\] $PS1"
    return
fi

# Call the above functions inside the PS1 declaration
export PS1='\[$(git_color)\]$(parse_git_branch)\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \$ '

#- to be used with new 'quest' command and .tmux.conf
function check_quest() {
  (quest updatecache --list brief >/dev/null && \
  quest updatecache --progress brief >/dev/null &)
}

export PROMPT_COMMAND='history -a; history -r; check_quest'

export PATH=/usr/src/courseware-lvm/quest_tool/bin:$PATH
export GEM_HOME=/opt/quest/gems/

# If not running interactively, do not do anything
#[[ $- != *i* ]] && exec tmux && return
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux && exec tmux attach

