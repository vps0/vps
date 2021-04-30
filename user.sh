echo "create user, what is the user name?"
read username
# create user
adduser $username

echo "user: " $username "created with success"

echo "add" $username "to SUDO group? (y - yes or n - no)"
read addRoot

if [ $addRoot == 'y' ]
then
    # add user to sudo group
    usermod -aG sudo $username
fi
# list users
cut -d: -f1 /etc/passwd

# Let's enable a color prompt
PS1='%F{%(#.blue.green)}┌──${debian_chroot:+($debian_chroot)──}$(venv_info)(%B%F{%(#.red.blue)}%n%(#.♠.ჟ)%m%b%F{%(#.blue.blue)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.blue)}]
└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '
