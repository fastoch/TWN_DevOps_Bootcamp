# Exercice 1 - clone and create new repo

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

# Exercice 2 - create .gitignore, empty Git cache, push changes

We don't want build folders and editor specific folders to be present in the remote repository.  
We should include them in a `.gitignore` file as a best practice, so they're not tracked by Git:
- first, switch to the project folder if not already there: `cd ~/DevOps/git-exercises`
- create a `.gitignore` file and edit it using Vim
- add the following entries :
  ```.gitignore
  .idea
  .DS_Store
  out
  build
  ```
- write and quit
- since some of these elements have already been committed, we need to remove them from Git cache:  
  - for the IntelliJ folder, we need the recursive flag: `git rm -r --cached .idea`
  - for the macOS file: `git rm --cached .DS_Store`
- Now that our Git cache is clean, we can stage changes, commit and push them to the remote repo: 
  ```bash
  git add .
  git commit -m "Add .gitignore file"
  git push
  ```

Now I can check my remote repo to make sure files included in my .gitignore are not present anymore.

# Exercice 3 - feature branch

- `cd` into the project folder
- create feature branch: `git checkout -b feature/ex3-changes`
- open the `build.gradle` file (at the project's root) in Vim and set the `logstash-logback-encoder` version to '7.3'
- open the `index.html` file (in src/main/webapp) and add an image:
  ```html
  <img src="https://www.careeraddict.com/uploads/article/58721/illustration-group-people-team-meeting.jpg" />
  ```  
- check changes using `git diff`
- stage changes: `git add .`
- commit changes: `git commit -m "Add image to index.html and set logstash-logback-encoder version to 7.3"`
- inform the remote repo about the new branch and push changes: `git push --set-upstream origin feature/ex3-changes`

>[!note]  
>The `--set-upstream` option is the long version of `-u`  

This command does 3 things: 
- it creates the branch on the remote repo if not already existing
- it pushes my local changes to the remote 
- it sets the specified branch as the reference for future `git pull` and `git push` commands

Only thing left to do is comparing main branch and feature branch on the remote repo to see my changes.  

# Exercice 4 - Bugfix branch

You find out there is a bug in your project, so you need to fix it using a new bugfix branch:  
- create new bugfix branch: `git checkout -b bugfix/ex4-changes`
- fix the spelling error in the `Application.java` file: 
  - from the project folder: `cd src/main/java/com/example` 
  - `vim Application.java`
  - at line 22, replace "Java app starte" with "Java app started"
  - write and quit
- check changes: `git diff`
- stage them if correct: `git add .`
- commit: `git commit -m "Fix spelling error in Application.java"`
- push to remote repo on the bugfix branch: `git push -u origin bugfix/ex4-changes`

# Exercice 5 - merge request

You are done with the feature, now it needs to be tested and deployed.  
For that, merge your feature branch into master using a merge request.  

From the CLI:
- switch to local master branch: `git checkout master`
- merge feature branch into master: `git merge feature/ex3-changes`
- push the merge to remote master: `git push`

To make sure it worked, check the remote repo on GitLab:
- go to Code > Branches and mouse over the commit counter (2 numbers separated by a pipe) beside the feature branch
- it should indicate "0 commits behind master, 0 commits ahead"

Alternatively, do the merge request from GitLab UI:
- connect to your GitLab account and select the "TWN-mod3-git-exercises" project
- click on "Code > Branches" in the left pane
- find the feature branch and click on "new merge request" on its right

# Exercice 6 - Fix merge conflict

You are on the local bugfix branch. You notice the logger library version is old, so you update it to version 7.2:
- switch to local bugfix branch: `git checkout bugfix/ex4-changes`
- open the `build.gradle` file in Vim and set the `logstash-logback-encoder` version to '7.2'


Since you've set the logger library version to 7.3 in the feature branch and you've already merged that into master, 


# Exercice 7

# Exercice 8

# Exercice 9

# Exercice 10