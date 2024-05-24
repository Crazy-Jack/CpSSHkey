#!/bin/bash

# Prompt for the username
read -p "Enter your username: " username

# Prompt for the server address
read -p "Enter the server address: " server_address

# Display the entered information
echo "Username: $username"
echo "Server Address: $server_address"

echo "Copying keys..."
echo "[1] RUN scp ~/.ssh/id_rsa_server.pub $username@$server_address:/home/$username/.ssh/id_rsa_server.pub"

server_home_ssh_dir_cmd="mkdir -p \$HOME/.ssh/"
ssh $username@$server_address "bash -c '${server_home_ssh_dir_cmd}'"

scp ~/.ssh/id_rsa_server.pub $username@$server_address:~/.ssh/

echo "[2] RUN scp ~/.ssh/id_rsa_server $username@$server_address:~/.ssh/id_rsa_server"
scp ~/.ssh/id_rsa_server $username@$server_address:~/.ssh/

echo "[3] Configuring server..."
ssh $username@$server_address 'bash -s' < server_configure.sh
