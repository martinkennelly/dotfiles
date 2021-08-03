#!/usr/bin/env bash
set -e
_HERE=$(dirname "$(readlink --canonicalize "$BASH_SOURCE")")
EMAIL="mkennell@redhat.com"
NAME="Martin Kennelly"

## config vim
echo "config vim"
if ! [ -d ~/.vim/autoload ]; then
  mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl --location --show-error --silent --output ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim &> /dev/null
fi

if ! [ -d ~/.vim/bundle/nerdtree ]; then
  git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
fi

if ! [ -d ~/.vim/bundle/vim-go ]; then
  git clone https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-go
fi

cp "$_HERE/.vimrc" ~/.vimrc
vim +GoInstallBinaries +qall
# end config vim

# config go
echo "config go"
go_ver=$(curl https://golang.org/VERSION?m=text 2> /dev/null)
echo "installing $go_ver"
go_file_path="/tmp/$go_ver.tar.gz"
rm -f "$go_file_path"
curl -LSso "$go_file_path" "https://dl.google.com/go/$go_ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "$go_file_path"
rm -f "$go_file_path"
cp "_HERE/.profile" ~/
echo "$go_ver installed"
# end config go

# config git
git config --global user.email "$EMAIL"
git config --global user.name "$NAME"
echo "git globals configured"

# install KIND
GO111MODULE="on" go get sigs.k8s.io/kind@latest
echo "KIND installed"

# install kubectl
sudo curl --location --show-error --silent --output /usr/local/bin/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" 2> /dev/null
