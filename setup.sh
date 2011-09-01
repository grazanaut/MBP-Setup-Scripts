#
#

#
# Set up chmod options for .ssh
#
echo 'Setting up permissions for .ssh folder and files'

echo 'chmod 700 ~/.ssh'
chmod 700 ~/.ssh

echo 'chmod 600 ~/.ssh/id_rsa'
chmod 600 ~/.ssh/id_rsa

echo 'chmod 644 ~/.ssh/id_rsa.pub'
chmod 644 ~/.ssh/id_rsa.pub

#
# Enable display of Library folder (necessary for Lion)
#
echo 'chflags nohidden ~/Library'
chflags nohidden ~/Library

#
# Install homebrew as user with sudo privileges
#
echo 'installing homebrew'
echo 'please enter the name of a user with sudo privileges: '
read SETUP_SH_SUDO_PRIV_USER
su - $SETUP_SH_SUDO_PRIV_USER -c /usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"

# Note - adding && to the end of any line will prevent the following line if it fails (as with most language command chains)

if [ $? -gt 0 ]; then
  # Double quotes below ensures that $? is parsed correctly
  echo "The previous command exited with code $? . Aborting..." 
  exit $?
fi


