export PS1="\[\e[96m\]\u\[\e[0m\]\[\e[0;33m\]\w\n\[\e[5;91m\]\$ \[\e[0m\] "
# Temp go-to-folder shortcuts
alias downloads="cd ~/Downloads"
alias pictures="cd ~/Pictures"
alias thriii="cd ~/Documents/Thriii"
alias salty="cd ~/Documents/salty-ui"
alias desk="cd ~/Desktop"
alias doc="cd ~/Documents"
# Alias
alias genstats=genstats
alias precompile="RAILS_ENV=production bundle exec rake assets:precompile"
alias clearcache="sudo dscacheutil -flushcache"
alias raketest="rake db:migrate RAILS_ENV=test"
alias uncommit="git reset --soft HEAD^"
alias undopush="git push -f origin HEAD^:master"
alias ebundle="bundle exec gem install"
alias airraid="sudo ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/sbin/airport && airport -s"
alias killapp="genghisapp --kill"
alias reload="clear; source ~/.bash_profile"
alias vmstop="vagrant halt"
alias mongod="sudo mongod"
alias gitsu="git push --set-upstream origin master"
alias raker="rake routes"
alias build="grunt dist"
alias gith="git push heroku master"
alias dbrb="rake db:rollback"
alias edbc="bundle exec rake db:create"
alias bash="subl ~/.bash_profile"
alias edbm="bundle exec rake db:migrate"
alias vmup="vagrant up"
alias list='ls -F'
alias simp='irb --simple-prompt'
alias dbc="rake db:create"
alias dbm="rake db:migrate"
alias app="genghisapp"
alias rm="rm -rf -i"
alias rc="rails c"
alias rs="rails s"
alias bi="bundle install"
alias ll='ls -la'
alias h='history'
export PATH=/usr/local/bin:$PATH
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/shims:$PATH"
push() {
  SUCCESS=false
  SSH=jaredcowan@sincitylivin.com
  if [ $# -gt 0 ]; then
    if [ $# -eq 1 ] && [ "$1" == "thriii" ]; then
      SUCCESS=true
      REMOTE=public_html/jaredlucascowan.com/thriii
      LOCALFILE=~/Documents/Thriii
      scp "$LOCALFILE/index.html" "$SSH:$REMOTE"
      scp -r "$LOCALFILE/css" "$SSH:$REMOTE/css"
      scp "$LOCALFILE/js/common-scripts.js" "$SSH:$REMOTE/js"
    elif [ $# -eq 2 ] && [ "$1" == "thriii" ] && [ "$2" == "-a" ]; then
      SUCCESS=true
      scp -r "$LOCALFILE/index.html" "$SSH:$REMOTE"
      scp -r "$LOCALFILE/css" "$SSH:$REMOTE"
      scp -r "$LOCALFILE/js" "$SSH:$REMOTE"
      scp -r "$LOCALFILE/assets" "$SSH:$REMOTE"
    elif [ "$1" == "bash" ]; then
      SUCCESS=true
      currentworkingdir=$(pwd)
      cd $HOME/bash-files
      if [ "$2" == "-m" ]; then
        printf "${RESET}${BOLD}${RED}Please don't use quotes.${RESET}\n"
        echo -n "Commit Message: "
        read commitmessageentry
        commitmessage='"'
        commitmessage+="${commitmessageentry}"
        commitmessage+='"'
      else
        commitmessage='"Updating Bash Files"'
      fi
      cp $HOME/.bash_profile $HOME/bash-files/bash_profile
      cp $HOME/.gitconfig $HOME/bash-files/git_config
      $(git d "${commitmessage}" && git p)
      cd $currentworkingdir
    elif [ !$SUCCESS ]; then
      echo "${RESET}${BLUE}${BOLD}$@ ${RESET}${RED} is not a valid argument for ${RESET}${BLUE}${BOLD}PUSH${RESET}"
    fi
    else
      echo "${RESET}${RED}No argument(s) supplied${RESET}"
  fi
}
install_htop() {
  cd ~
  printf "${RESET}${RED}$USER${RESET}${BCYAN}, We're going to curl and download the file\nin your home directory ${RESET}${RED}\"$PWD\".${RESET}\n"
  printf "${RESET}${GREEN}Here is a link to view what you're downloading, ${RED}$USER${RESET}.\n${BLUE}http://themainframe.ca/2011/06/install-htop-on-mac-os-x/${RESET}\n"
  echo -n "${RESET}${PURPLE}Would you like to continue with the download? ${RESET}${GREEN}yes${RESET}${RED}/${RESET}${RED}no:${RESET} "
  read response
  if [[ "$response" == "yes" || "$response" == "Yes" || "$response" == "YES" ]]; then
    curl -O "http://themainframe.ca/wp-content/uploads/2011/06/htop.zip"
    unzip htop.zip
    printf "\n${RESET}${RED}$USER${RESET}${BCYAN}, It's going to ask for your password as we need to run ${RESET}${RED}\"sudo mv htop /bin\"${RESET}.\n"
    echo -n "${RESET}${PURPLE}Would you like to continue? ${RESET}${GREEN}yes${RESET}${RED}/${RESET}${RED}no:${RESET} "
    read secondResponse
    if [[ "$secondResponse" == "yes" || "$secondResponse" == "Yes" || "$secondResponse" == "YES" ]]; then
      sudo mv htop /bin
      rm htop.zip
      printf "${RESET}${GREEN}You are all installed. Restart terminal and try running \"htop\"${RESET}\n"
    elif [[ "$secondResponse" == "no" || "$secondResponse" == "No" || "$secondResponse" == "NO" ]]; then
      printf "${RESET}${RED}Download canceled.${RESET}\n"
    fi
  elif [[ "$response" == "no" || "$response" == "No" || "$response" == "NO" ]]; then
    printf "${RESET}${GREEN}Download canceled.${RESET}\n"
  fi
}
checkfile() {
  lcl=$HOME/.bash_profile
  rmt=$HOME/bash-files/bash_profilee
  if [ $lcl -nt $rmt ]; then
    echo "File 1 is newer than file 2"
  else
    echo "File 1 is older than file 2"
  fi
}
lazy() { for x; do touch "$x"; open "$x"; done; }
dir() { for x; do mkdir "$x"; cd "$x"; done; }
geth() {
  printf "$USER, Here are your Git shortcuts. \n"
  printf "git s  = status\n"
  printf "git p  = push origin master\n"
  printf "git g  = pull\n"
  printf "git c  = commit -m\n"
  printf "git a  = add -A\n"
  printf "git co = checkout -b\n"
  printf "git b  = branch\n"
  printf "git rh = reset -head\n"
  printf "git st = status\n"
  printf "git d  = git add -A && git commit -m\n"
  printf "gitsu  = git push --set-upstream origin master\n"
  printf "gith   = git push heroku master\n"
}
genstats(){
  # echo ${BG_RED}${WHITE}GA${RESET}${WHITE}${BG_BLACK} General Assembly ${RESET}${BG_YELLOW}${BLACK} Web Development Immersive ${RESET}
  echo "------------------------------------------"
  echo $(ruby -v)
  echo $(rails -v)
  echo $(git --version)
  echo $(heroku --version)
  echo $(psql --version)
  echo $(brew -v)
  echo "------------------------------------------"
}
is_git_repo() {
  $(git rev-parse --is-inside-work-tree &> /dev/null)
}
is_git_dir() {
  $(git rev-parse --is-inside-git-dir 2> /dev/null)
}
get_git_branch() {
  local branch_name
    # Get the short symbolic ref
    branch_name=$(git symbolic-ref --quiet --short HEAD 2> /dev/null) ||
    # If HEAD isn't a symbolic ref, get the short SHA
    branch_name=$(git rev-parse --short HEAD 2> /dev/null) ||
    # Otherwise, just give up
    branch_name="(unknown)"
    printf $branch_name
  }
  prompt_git() {
    local git_info git_state uc us ut st
    if ! is_git_repo || is_git_dir; then
      return 1
    fi
    git_info=$(get_git_branch)
    # Check for uncommitted changes in the index
    if ! $(git diff --quiet --ignore-submodules --cached); then
      uc="+"
    fi
    # Check for unstaged changes
    if ! $(git diff-files --quiet --ignore-submodules --); then
      us="!"
    fi
    # Check for untracked files
    if [ -n "$(git ls-files --others --exclude-standard)" ]; then
      ut="${RED}?"
    fi
    # Check for stashed files
    if $(git rev-parse --verify refs/stash &>/dev/null); then
      st="$"
    fi
    git_state=$uc$us$ut$st
    # Combine the branch name and state information
    if [[ $git_state ]]; then
      git_info="$git_info${RESET}[$git_state${RESET}]"
    fi
    printf "${BLUE} on ${style_branch}${git_info}"
  }
  if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM=gnome-256color
  elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM=xterm-256color
  fi
  if tput setaf 1 &> /dev/null; then
    tput sgr0
    if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
    # this is for xterm-256color
    BLACK=$(tput setaf 0)
    RED=$(tput setaf 1)
    # GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 226)
    BLUE=$(tput setaf 4)
    MAGENTA=$(tput setaf 5)
    CYAN=$(tput setaf 6)
    WHITE=$(tput setaf 7)
    ORANGE=$(tput setaf 172)
    GREEN=$(tput setaf 190)
    PURPLE=$(tput setaf 141)
    BG_BLACK=$(tput setab 0)
    BG_RED=$(tput setab 1)
    BG_GREEN=$(tput setab 2)
    BG_BLUE=$(tput setab 4)
    BG_MAGENTA=$(tput setab 5)
    BG_CYAN=$(tput setab 6)
    BG_YELLOW=$(tput setab 226)
    BG_ORANGE=$(tput setab 172)
    BG_WHITE=$(tput setab 7)
  else
    MAGENTA=$(tput setaf 5)
    ORANGE=$(tput setaf 4)
    GREEN=$(tput setaf 2)
    PURPLE=$(tput setaf 1)
    WHITE=$(tput setaf 7)
  fi
  BOLD=$(tput bold)
  RESET=$(tput sgr0)
  UNDERLINE=$(tput sgr 0 1)
else
  BLACK="\[\e[0;30m\]"
  RED="\033[1;31m"
  ORANGE="\033[1;33m"
  GREEN="\033[1;32m"
  PURPLE="\033[1;35m"
  WHITE="\033[1;37m"
  YELLOW="\[\e[0;33m\]"
  CYAN="\[\e[0;36m\]"
  BCYAN="\[\e[0;96m\]"
  BLUE="\[\e[0;34m\]"
  BLINK="\[\e[5;34m\]"
  BOLD=""
  RESET="\033[m"
fi
export PATH=/bin:/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:$PATH
# export EDITOR='subl -w'
export EDITOR='subl'
export PATH=/usr/local/bin:$PATH
export PATH="$HOME/git-deploy/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export CLICOLOR=1
export LSCOLORS=faexcxdxbxegedabagacad
export LC_ALL="en_US.UTF-8"
export LANG="en_US"
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups
export HISTCONTROL=ignoreboth
export HISTIGNORE="h:ls:ls *:ll:ll *:"
PATH=/usr/local/share/npm/bin:$PATH
PATH="/Applications/Postgres.app/Contents/Versions/9.3/bin:$PATH"
PATH="/usr/local/heroku/bin:$PATH"
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
PS1+="\$(checkfile)"
if [ -f ~/.extra ]; then
  source ~/.extra
fi
