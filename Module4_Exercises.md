# Build Tools & Package Managers

Your team wants to build out a small helper library in Java and ask you to take over the project.

For these exercises, we'll use the following repo:  
https://gitlab.com/twn-devops-bootcamp/latest/04-build-tools/build-tools-exercises  

Example solutions:  
https://gitlab.com/twn-devops-bootcamp/latest/04-build-tools/build-tools-exercises/-/blob/feature/solutions/Solutions.md

# Exercise 0 - clone the project and create your own Git repo

- clone existing project: `git clone https://gitlab.com/twn-devops-bootcamp/latest/04-build-tools/build-tools-exercises.git`
- enter the project's directory: `cd build-tools-exercises`
- remove the remote repo reference: `rm -rf .git`
- initialize a local Git repo: `git init`
- stage all files: `git add .`
- make first commit: `git commit -m "Initial commit"`
- create my own remote repo: `git remote add origin git@gitlab.com:fastoch/TWN-mod4-git-exercises.git`
- push to my remote repo: `git push -u origin master`

# Exercise 1 - Build the .jar artifact

You want to deploy the artifact to share that library with all team members.  
To build the .jar file: ``

The Build will fail, because of a compile error in a test, so you can't build the jar.