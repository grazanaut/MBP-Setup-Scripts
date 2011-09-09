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
## FINISHED
##
