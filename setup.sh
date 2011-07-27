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
