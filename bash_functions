#!/usr/bin/env sh
push() {
  local SUCCESS SSH
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
      cd $HOME/bash-profile
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
      cp $HOME/.bash_functions $HOME/bash-profile/bash_functions
      cp $HOME/.bash_profile $HOME/bash-profile/bash_profile
      cp $HOME/.bash_aliases $HOME/bash-profile/bash_aliases
      cp $HOME/.bash_colors $HOME/bash-profile/bash_colors
      cp $HOME/.gitconfig $HOME/bash-profile/git_config
      cp $HOME/.profile $HOME/bash-profile/profile
      cp $HOME/.bashrc $HOME/bash-profile/bashrc
      git d "${commitmessage}" && git p
      cd $currentworkingdir
    elif [ !$SUCCESS ]; then
      echo "${RESET}${BLUE}${BOLD}$@ ${RESET}${RED} is not a valid argument for ${RESET}${BLUE}${BOLD}PUSH${RESET}"
    fi
    else
      echo "${RESET}${RED}No argument(s) supplied${RESET}"
  fi
}

checkfile() {
  local lcl=$HOME/.bash_profile
  local rmt=$HOME/bash-files/bash_profile
  if [ $lcl -nt $rmt ]; then
    echo "Local Files are newer than Remote Files"
  else
    echo "Remote Files are newer than Local Files"
  fi
}

_search() {
  local search_term site_name
  site_name=$1
  while (( "$#" )); do
      if [ "$2" ]; then 
        search_term+="$2+"
      fi
  shift; done
  open "http://www.$site_name.com/search?q=$search_term"
}

google() {
  _search "Google" $@
}

stackoverflow() {
  __search "Stackoverflow" $@
}

github() {
  __search "GitHub" $@
}

makegrunt() {
  local workingdir=$(pwd)
  local copysource=$HOME/.grunt-init

  if [[ $(pwd) != $HOME && $(pwd) != '/' ]]; then
    if [ ! -e $(pwd)/.secret.json ]; then
      printf '\n%s\n' "Created .secret.json"
      cp $copysource/.secret.json $workingdir/.secret.json
    else
      fileexist+=" .secret.json "
    fi

    if [ ! -e $(pwd)/.gitignore ]; then
      printf '\n%s\n' "Created .gitignore"
      cp $copysource/.gitignore $workingdir/.gitignore
    else
      fileexist+=" .gitignore "
    fi

    if [ ! -e $(pwd)/Gruntfile.js ]; then
      printf '\n%s\n' "Created Gruntfile.js"
      cp $copysource/Gruntfile.js $workingdir/Gruntfile.js
    else
      fileexist+=" Gruntfile.js "
    fi

    if [ ! -e $(pwd)/package.json ]; then
      printf '\n%s\n' "Created package.json"
      cp $copysource/package.json $workingdir/package.json
    else
      fileexist+=" package.json "
    fi

    if [ ! -z "$fileexist" ]; then
      printf '\n%s\n' "${RED}ERROR:${RESET}"
      printf '%s\n' "${YELLOW}These files already exist:"
      printf '%s\n' "$fileexist${RESET}"
    else
      printf '\n%s\n' "${RED}Sudo NPM install${RESET}"
      sudo npm install
    fi
  else
    printf '\n%s\n' "${RED}ERROR:${RESET}"
    printf '\t%s\n' "${YELLOW}Can't make these files in root!${RESET}"
    echo
  fi
}

lazy() { 
  for x
    do touch "$x"
    open "$x"
  done
}

dir() {
  for x
    do 
      mkdir "$x"
  done
}

geth() {
  cat <<-EOF
  $RED$USER,$RESET Here are your Git shortcuts. 
  ${WHITE}${BOLD} git   s  ${RESET} -> status
  ${WHITE}${BOLD} git   p  ${RESET} -> push origin master
  ${WHITE}${BOLD} git   g  ${RESET} -> pull
  ${WHITE}${BOLD} git   c  ${RESET} -> commit -m
  ${WHITE}${BOLD} git   a  ${RESET} -> add -A
  ${WHITE}${BOLD} git   co ${RESET} -> checkout -b
  ${WHITE}${BOLD} git   b  ${RESET} -> branch
  ${WHITE}${BOLD} git   rh ${RESET} -> reset -head
  ${WHITE}${BOLD} git   st ${RESET} -> status
  ${WHITE}${BOLD} git   d  ${RESET} -> git add -A && git commit -m
  ${WHITE}${BOLD} gitsu    ${RESET} -> git push --set-upstream origin master
  ${WHITE}${BOLD} gith     ${RESET} -> git push heroku master
EOF
}

genstats(){
  cat <<-GENSTATS
  ------------------------------------------
    $(ruby -v)
    $(rails -v)
    $(git --version)
    $(heroku --version)
    $(psql --version)
    $(brew -v)
  ------------------------------------------
GENSTATS
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