#!/usr/bin/env sh

# Since all my stuff is public. A little function to read data from a non-shared file.
# Create a file in your root directory(~) called configsecrets.yaml (touch ~/configsecrets.yaml)
# Then in that file. Start creating variables in yaml format. (http://en.wikipedia.org/wiki/YAML)
# example:
#   data:
#     username: John Doe
#     ipaddress: 192.168.1.1
# Get the data by calling $(secret test) -returns-> "Hello World!"

secret() {
  # File to read from
  local file=~/configsecrets.yaml

  # Assign parameter passed
  local argv=$1

  # We can read file based on line number passed.
  # local readFile=$(sed -n $1p $file)

  # Read file based on the line starting with the word passed as a parameter
  local readFile=$(grep "^$argv" $file)
  # Perform regex to return only the value of the variable
  ## Example: Given that our file has a variable called email=example@example.com
  ## from a function you could call $(secret email) and it would return example@example.com
  local fileRead=${readFile#*:}

  # Return the data
  echo $fileRead
}

# Full Yaml not ready yet
# read_config_yaml() {
#    local prefix=$2
#    local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
#    sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*$\)\"$s\$|\1$fs\2$fs\3|p" \
#         -e "s|^\($s\)\($w\)$s:$s\(.*$\)$s\$|\1$fs\2$fs\3|p"  $1 |
#    awk -F$fs '{
#       indent = length($1)/2;
#       vname[indent] = $2;
#       for (i in vname) {if (i > indent) {delete vname[i]}}
#       if (length($3) > 0) {
#          vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
#          printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
#       }
#    }'
# }

# secret() {
#   # Part of read_config_yaml()
#   # Just a replacement so I don't have to type `$ echo [$foo_variable_name]`
#   # I can type `$ secret [$foo_variable_name]` Just for more clarity
#   echo "$1"
# }

setupApp() {
  if [ -e `heroku info -s | grep web_url` ]; then
    echo -n "Name for your new Heroku app: "
    read appName
    if [ ${#appName} -eq 0 ]; then
      echo "No app name given"
      read -p "Do you want to try again? [y/n] " -n 1 -r
      if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        printf '\n%s' "Exiting..."
        kill -INT $$
      fi
    fi
    (heroku apps:create "${appName}")
  fi

  printf '\n%s\n' "Adding Heroku addons"
  (heroku addons:create heroku-postgresql)
  (heroku addons:create memcachier)
  (heroku addons:create newrelic)
  (heroku addons:create pgbackups)
  (heroku addons:create redistogo)
  (heroku addons:create sendgrid)

  printf '\n%s\n' "Adding Heroku ENV vars"
  (heroku config:add DEVISE_SECRET_KEY="$(bundle exec rake secret)")
  (heroku config:add DEVISE_PEPPER="$(bundle exec rake secret)")
  (heroku config:add SECRET_KEY_BASE="$(bundle exec rake secret)")
  (heroku config:set REDIS_URL=`heroku config:get REDISTOGO_URL`)
  (heroku config:add MAIL_HOST=`heroku info -s | grep web_url | cut -d= -f2`)
}

push() {
  local SUCCESS SSH
  SUCCESS=false
  SSH=$(secret email)

  if [ $# -gt 0 ]; then
    if [ "$1" == "bash" ]; then
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
      cp $HOME/.profile $HOME/bash-profile/profile
      cp $HOME/.bashrc $HOME/bash-profile/bashrc
      git c "${commitmessage}" && git p
      cd $currentworkingdir
    elif [ !$SUCCESS ]; then
      echo "${RESET}${BLUE}${BOLD}$@ ${RESET}${RED} is not a valid argument for ${RESET}${BLUE}${BOLD}PUSH${RESET}"
    fi
    else
      echo "${RESET}${RED}No argument(s) supplied${RESET}"
  fi
}

_search() {
  local web searchTerm siteName qBuilder

  case $1 in
    "web")
      web=$1
      siteName=$2
    ;;
    *)
      qBuilder=""
    ;;
  esac

  while (( $# )); do
    if [ ${#3} -ge 1 ]; then
      searchTerm+="$3+"
    else
      qBuilder+="$1 "
    fi
  shift; done

  if [ ${#searchTerm} -gt 0 ];then
    # We need to delete the extra '+' from end of string due to the extra passed params
    local searchUrl="http://www.${siteName}.com/search?q="${searchTerm%?}
    open $searchUrl
  else
    # Return built query string
    echo $qBuilder
  fi
}

help() {
  # Pass argv to _search function and return
  q=$(_search $@)
  # Open docs app from built query
  open dash://"$q"
}

google() {
  _search "web" "Google" $@
}

stackoverflow() {
  _search "web" "Stackoverflow" $@
}

github() {
  _search "web" "GitHub" $@
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

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

is_git_repo() {
  $(git rev-parse --is-inside-work-tree 2> /dev/null)
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
  if ! is_git_dir || is_git_repo; then
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

spam_mail() {
  local counter=0;

  while [ $counter -lt 200 ]; do
      # You can do sudo -S and pipe your password to the command
      # echo "my_password" | sudo -S <COMMAND>
      sudo scutil --set ComputerName `LC_ALL=C tr -dc "[:alpha:]" < /dev/random | head -c 8`
      sudo scutil --set LocalHostName `LC_ALL=C tr -dc "[:alpha:]" < /dev/random | head -c 8`
      sudo scutil --set HostName `LC_ALL=C tr -dc "[:alpha:]" < /dev/random | head -c 8`
      
      echo $RANDOM | mail -vs $RANDOM "satya@hiringassociate.com" -F PUT_EMAIL; let counter=counter+1;
      
      sleep .200;
  done
}

spam_chat() {
  local counter=0;

  while [ $counter -lt 200 ]; do
      curl -H "Content-Type: application/json" -d '{"notify": "true", "message": "hello"}' 'https://api.hipchat.com/v2/user/@jared/message?auth_token=u49ogz9U0RLl3QODYDcQx2hMRDLIKcnkz2y52V5D&format=json';
  done
}




