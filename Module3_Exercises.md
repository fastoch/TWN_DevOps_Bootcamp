# Exercice 1 - clone, make it yours, and push

Repo to use for this exercise: https://gitlab.com/twn-devops-bootcamp/latest/03-git/git-exercises  

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
  - display my public key via the command `cat ~/.ssh/id_ed25519.pub` and copy it
  - log in to the remote platform (GitLab), create an account if needed
  - go to Settings > Access > SSH keys
  - add my public key to GitLab
- push to my GitLab repo: `git push -u origin master`

# Exercice 2 - .gitignore

Build folders and editor specific folders are present in the remote repository.  
We should include them in the .gitignore file as a best practice, so they're not tracked by Git:
- first, switch to the project folder: `cd ~/DevOps/git-exercises`
- create a `.gitignore` file and add the following entries :
  ```.gitignore
  .idea
  .DS_Store
  out
  build
  ```
- since these elements have already been committed, we need to remove them from Git cache:  
  - for folders: `git rm -r --cached build out .idea`
  - for the file: `git rm --cached .DS_Store`
- stage changes, commit and push them to the remote repo: 
  ```bash
  git add .
  git commit -m "Add .gitignore file"
  git push
  ```

# Exercice 3

# Exercice 4

# Exercice 5

# Exercice 6

# Exercice 7

# Exercice 8

# Exercice 9

# Exercice 10