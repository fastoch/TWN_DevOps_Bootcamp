# The issue 

When I only had one ssh key pair on my machine, I was able to push to GitLab using that key.  
But after creating a second ssh key pair for DigitalOcean, I couldn't push to gitlab anymore ("permission denied").  

# The explanation

When you have multiple SSH keys, the SSH client defaults to trying the keys it finds in your ~/.ssh/ directory, often in alphabetical order. If the wrong key is presented to GitLab first, it rejects the connection, resulting in a "Permission denied (publickey)" error.  

# The solution

To resolve this, you need to explicitly tell your SSH client which key to use for each SSH access.  
For that, create or update your SSH configuration file located at `~/.ssh/config`:
```bash
Host gitlab.com
  HostName gitlab.com
  User git
  IdentityFile ~/.ssh/id_ed25519_your_gitlab_key
  IdentitiesOnly yes

Host digitalocean.com
  HostName digitalocean.com
  User root
  IdentityFile ~/.ssh/id_ed25519_your_digitalocean_key
  IdentitiesOnly yes

Host digitalocean.com
  HostName digitalocean.com
  User fastoch
  IdentityFile ~/.ssh/id_ed25519_your_digitalocean_key
  IdentitiesOnly yes
```

- **Host**: A nickname for the entry.
- **HostName**: The actual address (e.g., gitlab.com).
- **User**: For GitLab, this is always git.
- **IdentityFile**: The absolute path to your private key associated with GitLab.
- **IdentitiesOnly**: This is crucial; it forces SSH to only use the key specified here

>[!note]
>In this example, I've used "fastoch" as the username for my non-root user access to my DigitalOcean droplets.  
>Simply replace that name with your own username.

# Testing

You can test the connection to GitLab by running this command in your terminal:  
`ssh -T git@gitlab.com`