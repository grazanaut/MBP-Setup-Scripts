#!/bin/bash -xv

#
# Notes
# -v in the above shebang verbosely prints each command, so no need for echos
# Install anything required to be done with sudo and Administrator privileges
# Should be run as user with sudo privileges but *not* *using* sudo
#

#
# Reusable Methods and values
#

function errOutput() {
  #first arg should be the error code, eg: errOutput $?
  if [ $1 -gt 0 ]; then
    # Double quotes below ensures that $1 is parsed correctly
    echo "ERROR The previous command in setup_elevated.sh exited with code $1"
  fi
  return $1
}

##
## Install homebrew as user with sudo and Administrator privileges
##
SETUP_SH_HOMEBREW_INSTALLER_PATH=/tmp/tmp.homebrew.curl.rb

# from here on, we use && to only proceed if the last command succeeded
curl -o ~/.bashrc -fsSL https://raw.github.com/grazanaut/BashEnvOSX/master/bashrc &&
source ~/.bashrc &&
curl -o $SETUP_SH_HOMEBREW_INSTALLER_PATH -fsSL https://raw.github.com/gist/323731 &&
chmod 777 $SETUP_SH_HOMEBREW_INSTALLER_PATH &&
mkdir -p /usr/local/Cellar &&
"$SETUP_SH_HOMEBREW_INSTALLER_PATH" &&
rm $SETUP_SH_HOMEBREW_INSTALLER_PATH &&
# exit if there was an error above
true || errOutput $? || exit $?


##
## Install anything we're using homebrew for
##

brew list git-flow
# brew list will return error if not installed, so we install it
if [ $? -gt 0 ]; then
  brew install git-flow &&
  # exit if there was an error above
  true || errOutput $? || exit $?
fi

# Exit setup_elevated.sh normally
exit 0

##
## FINISHED
##
