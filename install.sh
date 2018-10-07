#!/bin/bash

CURDIR=$pwd

rm ~/.bashrc
ln -s $CURDIR/.bashrc ~/.bashrc

rm ~/.vimrc
ln -s $CURDIR/.vimrc ~/.vimrc

if [! -d "~/.vim/bundle/Vundle.vim"] ; then
  mkdir -p ~/.vim/bundle
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

