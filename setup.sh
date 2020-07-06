#!/bin/sh

current=$PWD

mkdir -p $HOME/.vim/bundle
cd $HOME/.vim/bundle
git clone https://github.com/chrisbra/Colorizer.git
git clone https://github.com/groenewege/vim-less.git
git clone https://github.com/jeetsukumaran/vim-buffergator.git
git clone https://github.com/jelera/vim-javascript-syntax.git
git clone https://github.com/kien/rainbow_parentheses.vim.git
git clone https://github.com/SirVer/ultisnips.git
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/tpope/vim-pathogen.git
git clone https://github.com/tpope/vim-vinegar.git
git clone https://github.com/vim-airline/vim-airline.git
git clone https://github.com/vim-scripts/nginx.vim.git
git clone https://github.com/vim-syntastic/syntastic.git
git clone https://github.com/ajmwagar/vim-deus.git
git clone https://github.com/posva/vim-vue.git
git clone https://github.com/airblade/vim-gitgutter.git

cd $current
mkdir -p $HOME/.vim/autoload/airline/themes
cp guzo-airline-theme.vim $HOME/.vim/autoload/airline/themes/guzo.vim
mkdir -p $HOME/.vim/colors
cp vividchalkian.vim $HOME/.vim/colors/vividchalkian.vim
cp -R UltiSnips $HOME/.vim/UltiSnips
cp vimrc $HOME/.vimrc
