# Exercises for Module "Cloud & IaaS - DigitalOcean"

Use repository: https://gitlab.com/twn-devops-bootcamp/latest/05-cloud/cloud-basics-exercises

You are asked to create a simple NodeJS app that lists all the projects each developer is working on.  
Everyone on your team wants to be able to see the list themselves and share with the project managers, 
so they ask you to make it available online, so everyone can access it.

# Exercise 0 - Clone Git repo

- clone the repo: `git clone git@gitlab.com:twn-devops-bootcamp/latest/05-cloud/cloud-basics-exercises.git`
- go to the project folder: `cd cloud-basics-exercises`
- remove the repo ref to make it your own: `rm -rf .git`
- initialize a new git repo: `git init`
- stage all files: `git add .`
- commit the files: `git commit -m "Initial commit"`
- create my own remote repo: `git remote add origin git@gitlab.com:fastoch/TWN-mod5-cloud-exercises.git`
- push to my remote repo: `git push -u origin master`

# Exercise 1 - Package NodeJS App

To have just 1 file, you create an artifact from the Node App.  
To package our Node app into a .tgz file:
- Make sure your app has a valid `package.json`, since `npm pack` builds the tarball from that manifest.
- while being in the project folder, go to the app folder where the package.json lives: `cd app`
- run `npm pack` to build the tarball

# Exercise 2 - Create a droplet server on DigitalOcean

- 

# Exercice solutions

You can find example solutions here:  
https://gitlab.com/twn-devops-bootcamp/latest/05-cloud/cloud-basics-exercises/-/blob/feature/solutions/Solutions.md