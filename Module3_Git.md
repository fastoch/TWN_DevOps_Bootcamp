# 3. Version Control with Git (module 3/16)

## Module Overview

In this module, we'll learn about "version control" and its most popular implementation: Git.  
Version control is used in software development to track and manage changes to source code over time.  

It's becoming more and more important in the DevOps space in order to manage the application configuration 
as part of the infrastructure as code (IaC) concept.  

As a DevOps engineer, we need to know how to use Git.  

## What is Version Control?

- Multiple developers are working on the same project, they need a place to **share** their work.  
- The code needs to be hosted **centrally** on the Web.  
- The place where code lives on the Web is called a "**repository**".
- Every developer has a **local copy** of the repository.
- We **fetch** the code from the repository to our local machine.
- We make some changes and then **push** those changes back to the repository.
- The next developer can then **pull** the changes from the repository and merge them into their local copy.
- They make some changes and then **push** those changes back to the repository.
- The process repeats until all the developers have pushed their changes to the repo
- This process is called **version control**.

## Merging & Conflicts

What happens when you and some other dev change the same files?  
>Git knows how to merge changes automatically

But what happens if you edit files for days while someone changes the same files in a completely different direction?  
>Git will **conflict**, changes are so different that Git is not able to sort this out  

In case of conflicts, you need to resolve them manually with the developer who has changed the same files as you.  
And that can be very tedious...  

Because of that, the best practice is to push and pull code as often as possible.  
This way, Git doesn't have to merge huge changes that overlap too much.  
This is called **Continuous Integration (CI)**.  

## Breaking changes

What happens if someone messes up and pushes changes that break the application?  

When someone pushes their breaking changes to the repo, it doesn't affect you until you pull these changes.  
Because you're working with your local copy of that repo.  

Once you pull those changes, your code includes the breaking changes too.  
But no need to panic, version control keeps the history of the changes to the repo.  

Every code change in every file is tracked in Git.  
Every commit made by other members of your team is a new history item.  

You can revert the commits, or simply go back to a previous version of the repository anytime.  
Hence the name "version control"...  

As the project moves forward, you don't have to worry about losing track of what changes have happened.  
Also, each change is labelled with commit messages, so you also know why such changes were made.  

Which is why your commits shouldn't be too large.  
First of all, this will make it easier to revert changes.  
And second, it's easier to describe small changes with a commit message.  

## Basic concepts of Git

Git is the most popular version control system. Alternative tools exist, such as SVN, for example.  
The inventor of Git is Linus Torvalds, the same person who created the Linux kernel.  

Git has multiple parts:
- the remote Git repository: where the code lives
- the UI (user interface): for interacting with the repository
- the local Git repository: where you store your local copy of the code
- the history of code changes: git log
- the staging area : where your working changes are stored before committing them to the remote repo
- the Git client: a UI tool or a CLI installed on your machine that lets you execute Git commands

![how_git_works](./assets/git.png)  

## How to set up a Git repo (remote & local)

### Remote repo

Various online platforms can host Git repositories, the most popular ones being:
- GitHub
- GitLab

- Repositories can be public or private depending on your choice
- You have to sign up for an account on these platforms to use them
- You can do a lot via these platforms UI, pretty much everything is there 
- Some companies have their own Git servers

### Local repo

- Git client needs to be installed first: can be a UI client or Git CLI
- Git CLI requires memorizing a handful of commands
- Git client needs to be connected with remote platform, which requires authenticating to GitHub/GitLab/...
- For that, once Git has been installed, you need to configure your username and email:
```bash
git config --global user.name "<username>"
git config --global user.email "<email>"
```  

- We can also add our public SSH key to the remote platform:
  - generate an SSH key pair on your local machine if you don't have one
  - log in to the remote platform
  - go to Settings -> SSH keys
  - add your public key
Once we've added our public key to the remote platform, it can authenticate us when pushing to or pulling from repo.  

After you've installed and configured the Git client, you can create a local repo:
- you can either clone an already existing remote repo: `git clone <url>`
- Or create a brand new local repo via the `git init` command

If you create a brand new repo, it will be empty at first, except for the `.git` folder.  
This folder contains information about the repo, such as the history of commits, the configuration, etc.  

## Working with files in Git

It's important to know the status a file can have in Git: 
- modified: when you make changes to a staged file
- untracked: when you create a new file
- staged: when you add a file to the staging area via `git add`
- committed: when you commit your changes via `git commit`
- pushed: when you push your changes to the remote repo via `git push`

The steps to work with files in Git are:
1. Create and edit a file
2. Add the file to the staging area
3. Commit changes to the local repo
4. Push changes to the remote repo

To get the status of your local git repo, run `git status`  
This will show you which branch you're on, your untracked files, your commits and changes to be committed.  

At first, your files are in the "working directory".  
If you use the `git add` command on these files, they will be moved to the staging area.  

To stage all untracked files/changes in the current folder, run `git add .`  
To stage a specific file, run `git add <file_name>`  
To unstage a file, run `git rm --cached <file_name>`  

Staged files are ready to be committed.  
If you modify a staged file, changes won't be part of the next commit, they will be unstaged.  
To discard changes in the working directory, run `git restore <file_name>`  

To commit your changes to the local repo, run `git commit -m "<message>"`  
Committing is confirming that you want to save your currently staged changes to the local repo.  
The history of your commits can be seen with `git log`  

**Recap**:  
working directory > staging area > local repo > remote repo  

Finally, to save changes to the remote repo, run: `git push`  

## Initializing a Git project locally

Sometimes you won't be cloning an existing Git repository.  
Instead, you'll be creating a new project from scratch.  
And once you decide to work with Git on this project, you'll need to initialize a local Git repo.  

You do that by running the `git init` command.  
This will create a new local repo, which you can then configure to point to a remote repo.  

I can stage all files via `git add .`  
I can commit all staged files via `git commit -m "<message>"`  

### Connecting a local repo to a remote repo

At this point, our local repo isn't connnected to any remote repo.  
We need to go to GitLab or GitHub to create a new empty project.  

Then, we need to copy our remote repo's URL.  
And finally, we can run `git remote add origin <url>` to connect the local repo to the remote repo.  

This last command tells my local repo where to push the changes to.  

Now, I can run `git push` to push my changes to the remote repo.  
But I'll get an **error** because repos are connected but not **branches**.  

### Connecting branches

We have to connect the main branch of our local repo to the main branch of our remote repo.  
This is done via `git push --set-upstream origin main`  

>[!note]
>Older repos might not have a "main" branch.  
>Instead they have a "master" branch.  

### The .git folder holds the configuration of the repo

The last two commands, `git remote add origin <url>` and `git push --set-upstream origin main`, 
modified the configuration of our Git repo and generated information that is stored in the `.git` folder.  

This folder stores the information about how to connect to the remote repo, where is the remote, which endpoint, 
and how the branches actually connect to each other.  

## Concept of Branches

master branch = main branch  
This is the branch that is created by default when initializing a Git repo  
Git stopped using the "master" word around 2020.  

Typical use case in a development team is:
- developing new features for an application
- fixing bugs in existing features

We said it's important to commit changes often and in small chunks to the main branch in the repo.  
Imagine what a mess the repo would be if all developers pushed their changes to the same branch...  

No one would know the actual state of the repo:
- Are the bugs fully fixed? 
- Are the new features fully implemented?

No one could tell when the repo is in a state where you can build the application and deploy it somewhere.  
The concept of branches exists in order to cleanly divide the work of different developers.  

Best practice is to create a branch for each feature and each bug fix.  
The naming standard is `feature/<feature_name>` or `bugfix/<bugfix_name>`  

This way, each dev can commit its half done or work in progress changes as often as they want without 
breaking other people's code.  

And once fully implemented and tested locally, a dev can say "my feature/bugfix is ready to be merged into the main branch".  
That's what we call a "**merge request**".  

>[!important]  
>Large feature branches that are open for too long increase the chance of merge conflicts.  
>That's why it's important to have small features that don't take weeks to implement.  
>Otherwise, developers will have to communicate and solve merge conflicts all the time...  

Using branches allows us to always have a stable main branch.  
Because we don't merge into the main branch until the feature/bugfix is ready.  

### Creating a new branch

2 ways:
- via the Git platform UI (GitHub/GitLab)
- via the `git checkout -b <branch_name>` command

#### Using the UI

It's best practice to create the new branch from the main one.  

To start working on the new branch, I have to tell my local repo.  
- To show all branches, run `git branch`  
- To inform my local repo about the new branch, run `git pull`  
- To switch to the new branch, run `git checkout <branch_name>`

#### Using the command line (faster)

- first, make sure you're on the main branch: run `git checkout main` if not
- then, create the new branch and switch to it: `git checkout -b <branch_name>`

This creates a branch locally, one that is based on the main branch.  
To inform the remote repo about the new branch: `git push --set-upstream origin <branch_name>`  
Now the branch should be visible in the remote repo.  

>[!tip]
>We don't have to memorize all these commands.  
>For example, when we simply run `git push`, we get a suggestion of the command to use.  
>Git is smart enough to understand what we want to do, and helps us with appropriate suggestions.  

What matters here is to keep in mind that we need to align our local repo with the remote one, and vice versa.  

### main and develop branches

A lot of projects actually have 2 main branches:
- **main**
- **develop**

The "**dev**" branch represents an **intermediary** step before the code is merged into the main branch.  
The main branch represents the **final** version of the code.  

The main branch is used for **releases** in **production**, while the develop branch is used for **testing/staging** environments.  

During what's called a "**sprint**", features and bug fixes are implemented and then merged into the develop branch.  
Once the sprint is over, the develop branch is merged into the main branch, and the main branch is "**released**".  

### Trunk based vs Feature based development

#### Trunk based development (only main branch)

- better for CI/CD (continuous integration/continuous delivery) pipeline
- pipeline is triggered every time a feature/bugfix code is merged into the main branch
- a CI/CD pipeline tests the code, builds the application, and deploys it to the staging/production environment

#### Feature based development (additional dev branch)

- many features and bugfixes are collected in the dev branch
- that big chunk of changes is merged into the main branch at the end of the sprint
- releases happen less often and require developers to carefully synchronize when it's time to merge dev into main

>[!important]
>The best practice in DevOps, the modern way of working, is to use trunk based development.  
>But as DevOps engineers, it's also important to know that some teams use feature based development.  
>Different companies have different Git workflows, some even have a third branch (staging or test branch).  

But the ideal goal remains to only have one main branch, and to build and deliver changes after every merge into the main branch.  

## Merge Requests

When a dev is done with a feature implementation or bug fix, another dev reviews the changes before merging them into the main branch.  
That's considered best practice, especially when coding a big feature or when job was assigned to a junior dev.  

When a dev submits code for review, we call that a **merge request** (GitLab), or a **pull request** (GitHub).  
If this dev knows someone in their team that has expertise in the relevant area, they can assign the merge request to that person.  

The code reviewer can either approve or decline the merge request.  
If the request is declined, they usually provide comments so the other dev can learn from their mistakes.  
If the request is approved, the code is merged into the main branch.  

## Deleting branches

What to do with a branch once it's been merged into the main branch?  
The best practice is to delete it right after merging.  

If that new code contains bugs, we should create a bugfix branch.  
If it requires some additional work to further improve the feature, we should create a feature branch.  

The advantage of deleting branches after merging into main is that you don't end up with hundreds of branches, 
where nobody knows which one is active, which one is completed, or which one has been merged into the main branch.  

Deleting branches in the remote repo is easy, the UI makes it very straightforward.  

To delete branches locally:
- `git branch` to see all branches
- `git checkout main` to switch to main branch
- `git pull` to update the local repo with latest changes
- `git branch -d <branch_name>` to delete the merged branch

