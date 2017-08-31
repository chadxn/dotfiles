export VIRTUAL_ENV_DISABLE_PROMPT=1
eval "$(rbenv init -)"

function get_trunc_path() {
    P=${PWD/#$HOME/'~'}
        
    TRUNC_PATH=`echo -n $P | awk -F "/" '{
        if (length($0) > 14) {
            if (NF>4) print $1 "/" $2 "/.../" $(NF-1) "/" $NF;
            else if (NF>3) print $1 "/" $2 "/.../" $NF;
            else print $1 "/.../" $NF;
        }
        else print $0;
        }'`
    echo "$TRUNC_PATH"
}

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[git: ${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

function get_python_venv {
    if test -z "$VIRTUAL_ENV" ; then
        echo ""
    else
        echo "[pyenv: `basename \"$VIRTUAL_ENV\"`]"
    fi
}

function old_get_ruby_rbenv {
    rbenv_ruby_version=`rbenv version | sed -e 's/ .*//'`
    if [ $rbenv_ruby_version == "system" ] ; then
        echo ""
    else
        echo "[rbenv: $rbenv_ruby_version]"
    fi
}

function get_ruby_rbenv {
    rbenv_global_ruby_version=`rbenv global 2> /dev/null`
    rbenv_local_ruby_version=`rbenv local 2> /dev/null`
    if [ ! $rbenv_local_ruby_version ] ; then
        if [ $rbenv_global_ruby_version == "system" ] ; then
            echo ""
        else
            echo "[rbenv: $rbenv_global_ruby_version]"
        fi
    else
        echo "[rbenv: $rbenv_local_ruby_version*]"
    fi
}

COLOR1="\[$(tput setaf 4)\]"
COLOR2="\[$(tput setaf 2)\]"
COLOR3="\[$(tput setaf 1)\]"
COLOR4="\[$(tput setaf 3)\]"
RESETCOLOR="\[$(tput sgr0)\]"

export PS1="${COLOR1}[\u@\h \D{%F %T}]${COLOR2}[\`get_trunc_path\`]${COLOR3}\`parse_git_branch\`${COLOR4}\`get_python_venv\`\`get_ruby_rbenv\`${RESETCOLOR}\n> "

