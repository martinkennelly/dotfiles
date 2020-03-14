#!/bin/bash
sudo apt update && sudo apt -y upgrade && sudo apt install gcc
FILEDIR=$(cd "$(dirname "$0")"; pwd)
rm -f ~/.bashrc
rm -f ~/.vimrc
rm -f ~/.vim

# Distribute bash/vim rcs
cp "$FILEDIR/.bashrc" ~/.bashrc
cp "$FILEDIR/.vimrc" ~/.vimrc

# Get vundle if not present
if [ ! -d "~/.vim/bundle/Vundle.vim" ]; then
  mkdir -p ~/.vim/bundle
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Get files to compile vim
sudo apt -y install libncurses5-dev libgnome2-dev libgnomeui-dev \
  libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
  libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
  python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev git

# Remove vim
sudo apt -y remove vim vim-runtime gvim

# Get python config dir name.
LASTDIR="$(ls /usr/lib/python3.* | grep -E 'config-[0-9a-z]')"
git clone https://github.com/vim/vim.git
cd vim

# Configure vim and attach py 3 config dir
./configure --with-features=huge \
            --enable-multibyte \
	    --enable-rubyinterp=yes \
	    --enable-python3interp=yes \
	    --with-python3-config-dir=/usr/lib/python3.5/$LASTDIR \
	    --enable-perlinterp=yes \
	    --enable-luainterp=yes \
            --enable-gui=gtk2 \
            --enable-cscope \
	   --prefix=/usr/local
make VIMRUNTIMEDIR=/usr/local/share/vim/vim82
sudo make install

# Let everyone know vim is installed
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim

# Get pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Get packages for color coded compilation
sudo apt-get -y install build-essential libclang-3.9-dev libncurses-dev libz-dev cmake xz-utils libpthread-workqueue-dev

# Get lua version
LUAVERSION="$(vim --version | grep -o "lua[0-9].[0-9]")"
sudo apt -y install lib$LUAVERSION-dev $LUAVERSION g++

# Install plugins
vim +PluginInstall +qall

# Compile color coded
cd ~/.vim/bundle/color_coded
rm -f CMakeCache.txt
mkdir build && cd build
cmake ..
make && make install
make clean && make clean_clang

# Install YCM & ask user whether C support or other lang
cd ~/.vim/bundle/YouCompleteMe
read -p 'Enter c for c based syntax checking otherwise something else for other languages:  ' langvar
if [ $langvar == "c" ]; then
  echo -e "\nYou choose C based language\n"
  python3 install.py --clang-completer
else
  echo -e "\nYou choose go,rust,java,npm,node,cargo\n"
  python3 install.py --all
fi

# Restore vim symbolic link
sudo ln -s /usr/bin/vi /usr/bin/vim
echo -e "\n=========================\n++++++++ COMPLETED +++++++\n========================="
