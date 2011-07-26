#
#

# Set up chmod options for .ssh
echo 'Setting up permissions for .ssh folder and files'
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
