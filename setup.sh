#!/bin/bash -v

#
# Notes
# -v in the above shebang verbosely prints each command, so no need for echos
#

#
# Reusable Methods
#

function quitIfErrcode() {
  #first arg should be the error code, eg: quitIfErrcode $?
  if [ $1 -gt 0 ]; then
    # Double quotes below ensures that $1 is parsed correctly
    echo "The previous command exited with code $1 . Aborting..." 
    exit $1
  fi
}

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
## Install homebrew as user with sudo privileges
##
SETUP_SH_HOMEBREW_INSTALLER_PATH=~/tmp.homebrew.curl.rb

# from here on, we use && to only proceed if the last command succeeded
read -p 'Please enter the name of a user with sudo privileges: ' SETUP_SH_SUDO_PRIV_USER

curl -o $SETUP_SH_HOMEBREW_INSTALLER_PATH -fsSL https://raw.github.com/gist/323731 &&
chmod 777 $SETUP_SH_HOMEBREW_INSTALLER_PATH &&
su - $SETUP_SH_SUDO_PRIV_USER -c "$SETUP_SH_HOMEBREW_INSTALLER_PATH" &&
rm $SETUP_SH_HOMEBREW_INSTALLER_PATH

# exit if there was an error above
quitIfErrcode $?

##
## FINISHED
##
