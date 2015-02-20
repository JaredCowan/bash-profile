# Loading All Bash Files
source ~/.bash_colors
source ~/.profile
source ~/.bashrc
source ~/.bash_aliases
source ~/.bash_functions
eval "$(rbenv init -)"
# Reminder to self
# Don't forget to change file permissions for any
# new scripts. -->> chmod u+rwx <file>"
export HOSTDBNAME=$(secret HOSTDBNAME)
export HOSTDBUSERNAME=$(secret HOSTDBUSERNAME)
export HOSTDBPASSWORD=$(secret HOSTDBPASSWORD)

export GMAIL=$(secret GMAIL)
export GMAILPASSWORD=$(secret gitPassword)

export AUTH_FACEBOOK_KEY=$(secret AUTH_FACEBOOK_KEY)
export AUTH_FACEBOOK_SECRET=$(secret AUTH_FACEBOOK_SECRET)
export AUTH_TWITTER_KEY=$(secret AUTH_TWITTER_KEY)
export AUTH_TWITTER_SECRET=$(secret AUTH_TWITTER_SECRET)
export AUTH_GITHUB_KEY=$(secret AUTH_GITHUB_KEY)
export AUTH_GITHUB_SECRET=$(secret AUTH_GITHUB_SECRET)
export AUTH_LINKEDIN_KEY=$(secret AUTH_LINKEDIN_KEY)
export AUTH_LINKEDIN_SECRET=$(secret AUTH_LINKEDIN_SECRET)
export DEVISE_SECRET_KEY=$(secret DEVISE_SECRET_KEY)
export DEVISE_PEPPER=$(secret DEVISE_PEPPER)
export SECRET_KEY_BASE=$(secret SECRET_KEY_BASE)