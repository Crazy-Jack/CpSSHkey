

# Tools for automatically configure server for github

## Configuring Github

Github requires rsa keys to pull and commit. It is very tedious to create new keys over and over again and upload them into the github security SSH Key page. The following tools help to reuse the key to any server newly created on vast ai. 

- Generating rsa key for Github.

To generate rsa key for github, please use `ssh-keygen -t rsa` to generate and make sure specifying the key name to be `id_rsa_server` and `id_rsa_server.pub` (Exact name). Then go to github.com and upload the content of your newly generated `id_rsa_server.pub`. This will allow github recognize your account. 


- Automatically copying the key to the newly created server. 

Next, we want to copy the newly generated key to the new server. The program is contained as `copy-github-key-to-server.sh` which will upload `id_rsa_server` and `id_rsa_server.pub` to the server `~/.ssh/`

To run, simply use:
```bash copy-github-key-to-server.sh```

It will takes the username and the server address. 
Enter your username: [your username]
Enter the server address: [your server address]

Make sure you have uploaded the rsa of your local machine to the vast.ai configuration. 
