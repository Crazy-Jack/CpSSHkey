# Create the .ssh directory if it doesn't exist
mkdir -p "$HOME/.ssh"

# chmod
chmod 600 $HOME/.ssh/id_rsa_server
chmod 644 $HOME/.ssh/id_rsa_server.pub


# Add the SSH configuration block to the configure


# Specify the target file
TARGET_FILE="$HOME/.ssh/config"

cat << EOF >> "$TARGET_FILE"

Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa_server

EOF

# Ensure correct permissions on the config file
chmod 600 "$TARGET_FILE"

echo "SSH configuration added to $TARGET_FILE"


# Fetch the GitHub SSH key and add it to known_hosts
ssh-keyscan github.com >> $HOME/.ssh/known_hosts

# Verify that the key was added
if grep -q github.com $HOME/.ssh/known_hosts; then
    echo "GitHub.com key successfully added to known_hosts."
else
    echo "Failed to add GitHub.com key to known_hosts."
    exit 1
fi

# test 
echo "[4] Verify github is correctly configured."
ssh -T git@github.com
echo "[5] Enjoy :)"
