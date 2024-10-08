# Create the .ssh directory if it doesn't exist
mkdir -p "$HOME/.ssh"

. $HOME/.ssh/backblaze.sh


if [ -e "/workspace/b2" ]; then
    echo "=> /workspace/b2 existed!"
else
    cd /workspace
    wget https://github.com/Backblaze/B2_Command_Line_Tool/releases/latest/download/b2-linux
    mv b2-linux b2
    chmod +x b2
    # authentica the b2

fi

echo $b2_keyID
/workspace/b2 account authorize $b2_keyID $b2_key


