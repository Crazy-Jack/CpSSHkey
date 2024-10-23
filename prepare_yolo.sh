#!/bin/bash


# Prompt for the command
read -p "Your ssh_command: " ssh_command

# Extract the port using sed
port=$(echo $ssh_command | sed -n 's/.*-p \([0-9]*\).*/\1/p')

# Extract the username and server address using awk
user_host=$(echo $ssh_command | awk '{print $4}')
username=$(echo $user_host | cut -d'@' -f1)
server_address=$(echo $user_host | cut -d'@' -f2)


# Display the entered information
echo "Username: $username"
echo "Server Address: $server_address"
echo "Port: $port"

echo "Copying keys..."
echo "[1] RUN scp ~/.ssh/id_rsa_server.pub $username@$server_address:/home/$username/.ssh/id_rsa_server.pub"

server_home_ssh_dir_cmd="mkdir -p \$HOME/.ssh/"
ssh -p $port $username@$server_address "bash -c '${server_home_ssh_dir_cmd}'"

scp -P $port ~/.ssh/id_rsa_server.pub $username@$server_address:~/.ssh/

echo "[2] RUN scp ~/.ssh/id_rsa_server $username@$server_address:~/.ssh/id_rsa_server"
scp -P $port ~/.ssh/id_rsa_server $username@$server_address:~/.ssh/

echo "[3] Configuring server..."
ssh -p $port $username@$server_address 'bash -s' < server_configure.sh

echo "[4] Configure b2"

scp -P $port ~/.ssh/backblaze.sh $username@$server_address:~/.ssh/
ssh -p $port $username@$server_address 'bash -s' < b2_configure.sh

echo "[5] Download ffcv and dataset"
ssh -p $port $username@$server_address 'bash -s' < config_yolo.sh
