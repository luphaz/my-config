#!/bin/zsh -ex

# Used to edit current directory into VSCode, yes I'm lazy
alias c="code ."

# Used to edit quickly zshrc into VSCode
alias ez="code ~/.zshrc ~/.aliases/"

# Used to open wercker into browser for current repo
ow() {open "https://app.wercker.com/ricardo-ch/$(basename `git rev-parse --show-toplevel`)/runs"}

# Kill all jobs in background using a do while like loop
kj() { 
  jobs
  kill %
  result=$?
  while [[ $result == 0 ]]
  do
    kill % 
    result=$?
    echo last command result is $result
    sleep 1
  done
}

# Used to run minikube shortly
alias mk=minikube

# Used to run kubectl shortly
alias k=kubectl

# Used to run isopod shortly 
alias i=isopod

# Used to run istioctl shortly 
alias ist=istioctl

# Used to run docker shortly
alias d=docker

# Used to run git shortly
alias g=git

# User to run vim shortly
alias v=vim

# Because colored git diff is way better that default diff available on MacOS
alias diff="git diff"

# Used to create a github pull request
alias gpr="hub pull-request"

# Create a pull request using first commit message
alias gprf="hub pull-request --no-edit"

# Create a pull request using last commit message
alias gprl='hub pull-request -m "$(git log -1 --pretty=%B)"'

# Open last pull request of current project
alias gpro='hub pr show'

# Used to rebase origin/master into current branch
alias grbom="git rebase origin/master"

# Used to git diff origin/master
alias gdom="git diff origin/master"

# Used to reset from origin/master
alias grom="git reset origin/master"

# Used to reset from origin/master HARD
alias gromh="git reset origin/master --hard"

# Go to ricardo go path
alias cdgo="cd $GORIC"

# Used to get ...
alias kg="kubectl get"

# Used to get all pods
alias kgp="kubectl get pods -o wide"

# Used to get deployment spec as yaml
alias kgy="kubectl get deploy -oyaml"

# Used to get deployment spec as yaml for all namespaces
alias kgya="kgy --all-namespaces"

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
alias kdev="kctx dev-cookie"

# Switch to prod context
alias kprod="kctx prod-cherry"

# Force grep color and insensitive by default
alias grep='grep --color -i'

# See all commits that contain the string $1 in their diff
git_dig() {
  git log --pretty=format:'%Cred%h%Creset - %Cgreen(%ad)%Creset - %s %C(bold blue)<%an>%Creset' --abbrev-commit --date=short -G"$1" -- $2
}
