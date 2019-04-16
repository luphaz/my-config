#!/bin/zsh -e

# As simple as possible setup, symlinks, try to be reproducible without impact
echo "-----------------------------------------------------------------------"
echo "BEGIN SETUP ZSH "

abs_zsh=$(pwd)/zsh

echo "-----------------------------------------------------------------------"
echo "symlink zsh/.aliases to ~/.aliases"
[  -d ~/.aliases ] && [ ! -h ~/.aliases ] && mv ~/.aliases ~/.aliases.backup
[ ! -h ~/.aliases ] && ln -s $abs_zsh/.aliases ~/.aliases
echo "~/.aliases is linked to"
readlink ~/.aliases

echo "-----------------------------------------------------------------------"
echo "symlink zsh/.zshrc to ~/zshrc"
[ ! -h ~/.zshrc ] && [ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.backup
[ ! -h ~/.zshrc ] && ln -s $abs_zsh/.zshrc ~/.zshrc
echo "~/.zshrc is linked to"
readlink ~/.zshrc

echo "-----------------------------------------------------------------------"
echo "symlink(s) zsh/.scripts/* to /usr/local/bin/."
for file in $abs_zsh/.scripts/*(.); echo "symlink $file to /usr/local/bin/${file:t:r}" \
    && [ ! -h /usr/local/bin/${file:t:r} ] \
    && ln -s $file /usr/local/bin/${file:t:r}

echo "-----------------------------------------------------------------------"
echo "END SETUP ZSH "
echo "-----------------------------------------------------------------------"
