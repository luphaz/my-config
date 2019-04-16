# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(

  git
  kubectl
  docker

  # Provide nice auto-complete from zsh history, avoid to retype command twice
  zsh-autosuggestions

  # Green when binary exists, red if not
  zsh-syntax-highlighting

  # dcup \o/
  docker-compose

  # g open
  git-open
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/id_rsa"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

DEFAULT_USER=$(id -un)

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context kubecontext dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time battery)
POWERLEVEL9K_TIME_BACKGROUND='025'

POWERLEVEL9K_KUBECONTEXT_FOREGROUND='233'
POWERLEVEL9K_KUBECONTEXT_BACKGROUND='008'

POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"

# GOPATH to store vendor into
export GOPATH=~/Git/go
# Go shortcut to jump
export GORIC=$GOPATH/src/github.com/ricardo-ch/
# Useful for I don't remember what
export GOROOT="/usr/local/opt/go/libexec"

# https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md
export NPM_PACKAGES="${HOME}/.npm-packages"
unset MANPATH
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# Path concatenation, because path is never enough
export PATH="${PATH}:/usr/local/opt/node@10/bin:${NPM_PACKAGES}/bin:${GOPATH}/bin:/usr/local/bin/kafka/bin:/usr/local/bin/google-cloud-sdk/bin"

# Awesome trick to auto-complete directory you go often, any directory behind Git/Go/Home is just one `cd dir-name` aways
cdpath=($HOME $GORIC ~/Git)

# Yeah kind of a backup
export OLDGIT=~/Old/Git

# Useful to speedup docker at some point
export NO_PROXY=*

# Prefer VSCode to edit kubectl files
export KUBE_EDITOR="code --wait"

# Ensure apps run using dev configuration lby default
export ENVIRONMENT=DEV

# Source all aliases available into folder
for file in ~/.aliases/.*.zsh; source $file

# Fuzzy finding configuration if exists
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Stern is useful to concatenate k8s logs
source <(stern --completion=zsh)
