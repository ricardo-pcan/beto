#!/bin/bash

# THis is the provision script for my new instalation at xubuntu 14.04

sudo apt-get upgrade
sudo apt-get update

export DEBIAN_FRONTEND=noninteractive
echo mysql-server mysql-server/root_password root root | debconf-set-selections
echo mysql-server mysql-server/root_password_again root root | debconf-set-selections

# Install ppa repos
sudo add-apt-repository ppa:banshee-team/ppa -y
sudo add-apt-repository ppa:ubuntu-mozilla-daily/ppa -y
sudo add-apt-repository ppa:webupd8team/java -y

sudo apt-get update

# Google repository
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

PACKAGES="ubuntu-restricted-extras terminator gimp i3 vim vim-gnome inkscape mysql-server libapache2-mod-auth-mysql php5-mysql rpcbind nfs-common nfs-kernel-server php5 libapache2-mod-php5 php5-mcrypt"
PACKAGES="$PACKAGES python-pip python-dev build-essential tmux zsh arandr feh git-cola synaptic banshee curl google-chrome-stable firefox-trunk git"
PACKAGEs="$PACKAGES git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev"
PACKAGES="$PACKAGES libgdbm-dev libncurses5-dev automake libtool bison libffi-dev"

sudo apt-get install -y $PACKAGES

# Install pip modules
sudo pip install --upgrade pip
sudo pip install --upgrade virtualenv
sudo pip install --upgrade fabric

#install vim spf13
curl http://j.mp/spf13-vim3 -L -o - | sh
curl -sSL https://get.docker.com/ | sh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Install nvm and nodejs
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | bash
echo "source /home/$USER/.nvm/nvm.sh" >> /home/$USER/.profile
source /home/$USER/.profile
nvm install 0.12
nvm use 0.12

#Install rvm
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.2.2
rvm use 2.2.2 --default
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler

# Customization
rm ~/.zshrc
sudo cp ./customFiles/.zshrc ~/
mkdir ~/.i3
sudo cp ./customFiles/config ~/.i3/
rm ~/.gitconfig
sudo cp ./customFiles/.gitconfig ~/

sudo cp ./customFiles/.c_bin/ ~/

# Create environment folders
mkdir myjunk myprojects myrepos myinbox mywork myvideos myimages myreferences


