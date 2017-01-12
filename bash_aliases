#!/usr/bin/env sh
# Quick Folder Change
alias gitdeploy="cd ~/git-deploy"
alias bashfiles="cd ~/bash-profile"
alias downloads="cd ~/Downloads"
alias pictures="cd ~/Pictures"
alias thriii="cd ~/Documents/Thriii"
alias salty="cd ~/Documents/salty-ui"
alias sublime="cd ~/Library/Application\ Support/Sublime\ Text\ 3"
alias desk="cd ~/Desktop"
alias doc="cd ~/Documents"
alias pro="cd ~/Documents/projects"
# Open Bash Profile Files
alias bf="subl ~/.bash_functions"
alias bp="subl ~/.bash_profile"
alias ba="subl ~/.bash_aliases"
alias br="subl ~/.bashrc"
alias bpp="subl ~/.profile"
alias gc="subl ~/.gitconfig"
alias secrets="subl ~/configsecrets.yaml"
# Life Saving Aliases
alias genstats=genstats
alias precompile="RAILS_ENV=production bundle exec rake assets:precompile"
alias clearcache="sudo dscacheutil -flushcache"
alias raketest="rake db:migrate RAILS_ENV=test"
alias uncommit="git reset --soft HEAD^"
alias undopush="git push -f origin HEAD^:master"
alias ebundle="bundle exec gem install"
alias airraid="sudo ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/sbin/airport && airport -s"
alias killapp="genghisapp --kill"
alias compile="rake assets:precompile"
alias reload="clear; source ~/.bash_profile"
alias RELOAD="clear; source ~/.bash_profile"
alias vmstop="vagrant halt"
alias mongod="sudo mongod"
alias gitsu="git push --set-upstream origin master"
alias raker="rake routes"
alias build="grunt dist"
alias gith="git push heroku master"
alias dbrb="rake db:rollback"
alias edbc="bundle exec rake db:create"
alias edbm="bundle exec rake db:migrate"
alias vmup="vagrant up"
alias list='ls -F'
alias simp='irb --simple-prompt'
alias dbc="rake db:create"
alias dbm="rake db:migrate"
alias hrc="heroku run rails c"
alias hdbm="heroku run rake db:migrate"
alias hdbc="heroku run rake db:create"
alias sidekick="bundle exec sidekiq -C config/sidekiq.yml"
alias memcached="/usr/local/opt/memcached/bin/memcached"
alias redis="redis-server /usr/local/etc/redis.conf &"
alias cc="rake tmp:cache:clear"
alias sc="rake tmp:sockets:clear"
alias ccall="rake tmp:clear"
alias app="genghisapp"
alias rm="rm -rf -i"
alias rc="rails c"
alias rs="rails s"
alias bi="bundle install"
alias ll='ls -alF'
alias la='ls -a'
alias h='history'