#!/bin/bash -xv

#
# Notes
# -v in the above shebang verbosely prints each command, so no need for echos
#

#
# Reusable Methods and values
#

function errOutput() {
  #first arg should be the error code, eg: errOutput $?
  if [ $1 -gt 0 ]; then
    # Double quotes below ensures that $1 is parsed correctly
    echo "ERROR The previous command in setup.sh exited with code $1"
  fi
  return $1
}

 SETUP_SH_USER=`whoami` &&
#SETUP_SH_SUDO_PRIV_USER==>capture user now, but we will be warned each time privileges are elevated
read -p 'Please enter the name of a user with sudo and Administrator privileges: ' SETUP_SH_SUDO_PRIV_USER  &&
# exit if there was an error above
true || errOutput $? || exit $? 

#
# Set up chmod options/permissions for .ssh folder and files
#
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub

#
# Enable display of Library folder (necessary for Lion)
#
chflags nohidden ~/Library

#
# Pull down bashrc and any dependencies
#

# Bashrc pulls down git-completion if it does not already exist. If we want a different version change it here 
curl -o ~/.git-completion.bash https://github.com/git/git/raw/master/contrib/completion/git-completion.bash -L &&
# Now the actual bashrc & bash_profile
curl -o ~/.bash_profile -fsSL https://raw.github.com/grazanaut/BashEnvOSX/master/bash_profile &&
curl -o ~/.bashrc -fsSL https://raw.github.com/grazanaut/BashEnvOSX/master/bashrc &&
source ~/.bashrc

##
## Install the following as user with sudo and Administrator privileges
## - homebrew
## -- git-flow
##

cp ./setup_elevated.sh /tmp/ &&
su - $SETUP_SH_SUDO_PRIV_USER -c "/tmp/setup_elevated.sh" &&
rm /tmp/setup_elevated.sh &&
# exit if there was an error above
true || errOutput $? || exit $? 

##
## Install Gilles Ruppert's VIMRC repository (forked to grazanaut)
##

git clone --recursive git@github.com:grazanaut/vimrc.git ~/Documents/DevProjs/.vim
cp ~/.vim/vimrc ~/.vimrc
# requires setting editor in gitconfig. RUN THIS ONLY ONCE!
echo '[core]' >> ~/.gitconfig
echo -e "\teditor = /usr/bin/vim" >> ~/.gitconfig

##
## Install RVM
##

bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)
# exit if there was an error above
errOutput $? || exit $? 
echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function' >> ~/.bash_profile
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

##
## Install Ruby 1.9.2 and bundler
##

rvm install 1.9.2
rvm use ruby-1.9.2
gem install rails thin bundler


##
## FINISHED
##
