# Loading All Bash Files
source ~/.bash_colors
source ~/.profile
source ~/.bashrc
source ~/.bash_aliases
source ~/.bash_functions
# The next line updates PATH for the Google Cloud SDK.
source '/Users/JaredMBP/google-cloud-sdk/path.bash.inc'
# The next line enables bash completion for gcloud.
source '/Users/JaredMBP/google-cloud-sdk/completion.bash.inc'
eval "$(rbenv init -)"
# eval $(read_config_yaml ~/configsecrets.yaml)

export HOSTDBNAME=$(secret HOSTDBNAME)
export HOSTDBUSERNAME=$(secret HOSTDBUSERNAME)
export HOSTDBPASSWORD=$(secret HOSTDBPASSWORD)

export GMAIL=$(secret GMAIL)
export GMAILPASSWORD=$(secret gitPassword)

export GENERAL_AUTH_GOOGLE_KEY=$(secret GENERAL_AUTH_GOOGLE_KEY)
export GENERAL_AUTH_GOOGLE_SECRET=$(secret GENERAL_AUTH_GOOGLE_SECRET)

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

export SECRET_TOKEN=$(secret GIT_SHA)

export GH_TOKEN=$(secret GH_TOKEN)
export GH_VALUE=$(secret GH_USERNAME)

# Teddytrucking
export TEDDYTRUCKING_GOOGLE_ANALYTICS_ID=$(secret TEDDYTRUCKING_GOOGLE_ANALYTICS_ID)

# Verde Forum
export VERDE_FORUM_AUTH_FACEBOOK_KEY=$(secret VERDE_FORUM_AUTH_FACEBOOK_KEY)
export VERDE_FORUM_AUTH_FACEBOOK_SECRET=$(secret VERDE_FORUM_AUTH_FACEBOOK_SECRET)

export VERDE_FORUM_AUTH_TWITTER_KEY=$(secret VERDE_FORUM_AUTH_TWITTER_KEY)
export VERDE_FORUM_AUTH_TWITTER_SECRET=$(secret VERDE_FORUM_AUTH_TWITTER_SECRET)

export VERDE_FORUM_AUTH_GITHUB_KEY=$(secret VERDE_FORUM_AUTH_GITHUB_KEY)
export VERDE_FORUM_AUTH_GITHUB_SECRET=$(secret VERDE_FORUM_AUTH_GITHUB_SECRET)

export VERDE_FORUM_AUTH_LINKEDIN_KEY=$(secret VERDE_FORUM_AUTH_LINKEDIN_KEY)
export VERDE_FORUM_AUTH_LINKEDIN_SECRET=$(secret VERDE_FORUM_AUTH_LINKEDIN_SECRET)

export VERDE_FORUM_AUTH_GOOGLE_KEY=$(secret VERDE_FORUM_AUTH_GOOGLE_KEY)
export VERDE_FORUM_AUTH_GOOGLE_SECRET=$(secret VERDE_FORUM_AUTH_GOOGLE_SECRET)

export VERDE_FORUM_GOOGLE_ANALYTICS_ID=$(secret VERDE_FORUM_GOOGLE_ANALYTICS_ID)

export VERDE_FORUM_DEVISE_SECRET_KEY=$(secret VERDE_FORUM_DEVISE_SECRET_KEY)
export VERDE_FORUM_DEVISE_PEPPER=$(secret VERDE_FORUM_DEVISE_PEPPER)
export VERDE_FORUM_SECRET_KEY_BASE=$(secret VERDE_FORUM_SECRET_KEY_BASE)
# End Verde Forum

# Reminder to self
# Don't forget to change file permissions for any
# new scripts. -->> chmod u+rwx <file>"
