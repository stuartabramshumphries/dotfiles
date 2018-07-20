# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific aliases and functions

# User specific aliases and functions
if [ -f /etc/bash_completion.d/git ]; then
  . /etc/bash_completion.d/git
fi
# show pending (+ = new files, * = changed files) state
#export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\[\033[01;32m\][\[\033[01;35m\]\u\[\033[01;32m\]@\h\[\033[01;34m\] \w\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\]\[\033[01;32m\]]\n\[\033[00m\]\$ '
function _git_prompt() {
  local git_status="`git status -unormal 2>&1`"
    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
      if [[ "$git_status" =~ nothing\ to\ commit ]]; then
        local ansi=32
          elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
          local ansi=31
      else
        local ansi=33
          fi
          echo -n '\[\e[0;33;'"$ansi"'m\]'"$(__git_ps1)"'\[\e[0m\]'
          fi
}
function _prompt_command() {
  PS1="`if [ \$? = 0 ]; then echo -n '\[\e[0;33;32m\]^-^';else echo -n '\[\e[0;33;31m\]-_-';fi`\[\033[00m\] \u@\h \[\033[36m\]\w `_git_prompt`\[\033[37m\]$\[\033[00m\] "
}
PROMPT_COMMAND=_prompt_command
source ~/.bash_git
export CDPATH=.:~
