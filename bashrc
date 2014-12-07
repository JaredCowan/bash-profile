export PS1="\[\e[96m\]\u\[\e[0m\]\[\e[0;33m\]\w\n\[\e[5;91m\]\$ \[\e[0m\] "
style_user="\[${RESET}${YELLOW}\]"
style_path="\[${RESET}${CYAN}\]"
style_chars="\[${RESET}${BLUE}\]"
style_chartwo="\[${RESET}${PURPLE}\]"
style_branch="${RED}"
PS1="${style_user}\u"
PS1+="${style_path} \w"
PS1+="\$(prompt_git)"
PS1+="\n"
PS1+="${style_chars}\$ \[${RESET}\]"
export CLICOLOR=1
export LSCOLORS=faexcxdxbxegedabagacad
export EDITOR='subl -w'
export LC_ALL="en_US.UTF-8"
export LANG="en_US"
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups
export HISTCONTROL=ignoreboth
export HISTIGNORE="h:ls:ls *:ll:ll *:"
shopt -s histappend
shopt -s cdspell
shopt -s cmdhist
PROMPT_COMMAND='history -a'