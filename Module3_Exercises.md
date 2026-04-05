# Exercice 1 - clone, make it yours, and push

- Clone the exercise repo: `git clone https://gitlab.com/twn-devops-bootcamp/latest/03-git/git-exercises.git`
- Then switch to the project folder: `cd git-exercises`
- Before pushing to my own personal repo, I need to remove the remote repo reference: `rm -rf .git`
- create my own local repo: `git init`
- stage all files: `git add .`
- make initial commit: `git commit -m "Initial commit"`
- create my own remote repo: `git remote add origin git@gitlab.com:<gitlab_user>/<gitlab_repo>.git`
  - in my case: `git remote add origin git@gitlab.com:fastoch/TWN-mod3-git-exercises.git`
- adding our public SSH key to the remote repo:
  - generate an SSH key pair on my local machine: `ssh-keygen -t ed25519 -C "fastoch-gitlab"`
  - log in to the remote platform (GitLab), create an account if needed
  - go to Settings -> SSH keys
  - add my public key 
- push to my GitLab repo: `git push -u origin master`

# Exercice 2



# Exercice 3

# Exercice 4

# Exercice 5

# Exercice 6

# Exercice 7

# Exercice 8

# Exercice 9

# Exercice 10