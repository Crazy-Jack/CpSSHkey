#!/bin/bash

echo "#############################"
echo "#    Remote Server Login    #"
echo "#############################"

read -p "Remote username: " remote_login_usr_name
read -p "Remote server_address: " remote_server_addr 

echo "#############################"
echo "#    Remote User Creation   #"
echo "#############################"

read -p "Creating new user for this instance? (yes or no): " create_user

case "$create_user" in 
    [yY][eE][sS]|[yY])
        read -p "Enter the new username: " username
        read -p "Add $username to the sudo group? (y/n): " add_to_sudo
        # Create a script to be executed on the remote server
ssh_script=$(cat << EOF
# Create the user and their home directory
sudo useradd -m $username 

# Optionally, add the user to the sudo group
sudo usermod -aG sudo $username 
echo "$username added to the sudo group" 
echo "User $username created successfully"
EOF
        )
        ssh $remote_login_usr_name@$remote_server_addr 'bash -s' <<< "$ssh_script"
        
        # sourcing local login crediential to the remote server under new user name
copy_id_script=$(cat << EOF
# create .ssh folder for the new user
mkdir -p /home/$username/.ssh

sudo cp /root/.ssh/authorized_keys /home/$username/.ssh/authorized_keys
# change the owner of the .ssh back to user
sudo chown -R $username /home/$username/.ssh
# change file security to targetuser
sudo chmod 700 /home/$username/.ssh
sudo chmod 600 /home/$username/.ssh/authorized_keys

)
        ssh $remote_login_usr_name@$remote_server_addr 'bash -s' <<< "$copy_id_script"

        ;;
    [nN][oO]|[nN])
        echo "No user created. \nWARNING: root user will be used!"
        username="root"
        ;;
    *)
        echo "Invalid input. Please enter yes or no."
        ;;
esac



