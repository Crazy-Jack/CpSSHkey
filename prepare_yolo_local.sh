#!/bin/bash


# Prompt for the command

echo "Copying keys..."
echo "[1] RUN scp ~/.ssh/id_rsa_server.pub $username@$server_address:/home/$username/.ssh/id_rsa_server.pub"

server_home_ssh_dir_cmd="mkdir -p \$HOME/.ssh/"
ssh -p $port $username@$server_address "bash -c '${server_home_ssh_dir_cmd}'"

scp -P $port ~/.ssh/id_rsa_server.pub $username@$server_address:~/.ssh/

scp -P $port ~/.ssh/id_rsa_server $username@$server_address:~/.ssh/

bash server_configure.sh


scp -P $port ~/.ssh/backblaze.sh $username@$server_address:~/.ssh/
bash b2_configure.sh

bash config_yolo.sh
