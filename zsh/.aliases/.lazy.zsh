#!/bin/zsh -ex

# Used to edit current directory into VSCode, yes I'm lazy
alias c="code ."

# Used to edit a file as root, only for /etc/hosts, avoid using too much root power
alias cr="sudo code --user-data-dir='~/.vscode-root' /etc/hosts"

# Used to edit quickly zshrc into VSCode
alias ez="code ~/.zshrc ~/.aliases/"

# Used to open wercker into browser for current repo
ow() {open "https://app.wercker.com/ricardo-ch/$(basename `git rev-parse --show-toplevel`)/runs"}

# Used to run minikube shortly
alias mk=minikube

# Used to run kubectl shortly
alias k=kubectl

# Used to run istio shortly 
alias i=istioctl

# Used to run docker shortly
alias d=docker

# Used to run git shortly
alias g=git

# Used to create a github pull request
alias gpr="hub pull-request"

# Create a pull request using first commit message
alias gprf="hub pull-request --no-edit"

# Create a pull request using last commit message
alias gprl='hub pull-request -m "$(git log -1 --pretty=%B)"'

# Alias to open last stdout stuff
alias ol="open !!"

# Used to rebase origin/master into current branch
alias grom="git rebase origin/master"

# Go to ricardo go path
alias cdgo="cd $GORIC"

# Used to get ...
alias kg="kubectl get"

# Used to get all pods
alias kgp="kubectl get pods -o wide"

# Used to shorten the port forward command :
alias kpf="kubectl port-forward"

# Used to get all pods on all namespaces
alias kgpa="kgp --all-namespaces"

# Use to clean docker images & instance unused
alias dclean="docker run --rm --privileged=true -v /var/run/docker.sock:/var/run/docker.sock -v /etc:/etc:ro spotify/docker-gc"

# Shorten docker-compose command
alias dc="docker-compose"

# Provide retro-compatibility
alias kctx="kubectx"

# Provide retro-compatibility
alias kns="kubens"

# Switch to dev context
alias kdev="kctx dev"

# Switch to prod context
alias kprod="kctx prod"

# Force grep color and insensitive by default
alias grep='grep --color -i'

# See all commits that contain the string $1 in their diff
git_dig() {
  git log --pretty=format:'%Cred%h%Creset - %Cgreen(%ad)%Creset - %s %C(bold blue)<%an>%Creset' --abbrev-commit --date=short -G"$1" -- $2
}
