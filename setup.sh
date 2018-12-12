#!/bin/bash

# Setup sensible .vimrc defaults

echo "
set number
set expandtab
set tabstop=2
set shiftwidth=2
syntax on
" > ~/.vimrc

# Install apps

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

casks="
  spectacle
  textmate
  sublime-text
  spotify
  gitx-dev
  docker
  disk-inventory-x
  kindle
"

for cask in $casks; do 
  brew cask install $cask
done 

formulae="
  tmux 
  git 
  tldr
"

for formula in $formulae; do
  brew install $formula
done


# Generate Github SSH Keys

ssh-keygen -t rsa \
 -b 4096 \
 -C "atticusberg@gmail.com" \
 -f ~/.ssh/github-ssh-keypair \
 -P ''

eval "$(ssh-agent -s)"

echo "Host *
 AddKeysToAgent yes
 UseKeychain yes
 IdentityFile ~/.ssh/github-ssh-keypair
" > ~/.ssh/config
 
ssh-add -K ~/.ssh/github-ssh-keypair

mate ~/.ssh/github-ssh-keypair.pub
open https://github.com/settings/keys

# Setup bash

cd ~
mkdir code
cd code
git clone git@github.com:/peteratticusberg/clip-ins.git
echo "EXTENSIONS_DIR=~/code/clip-ins/extensions" >> ~/.bash_profile
ls -o clip-ins/extensions | awk '{print $8}' | sed s/^/'# source "$EXTENSIONS_DIR"\/'/ >> ~/.bash_profile
mate ~/.bash_profile













  


