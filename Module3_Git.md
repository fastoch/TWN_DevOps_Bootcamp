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

## Initialize a Git project locally

Sometimes you won't be cloning an existing Git repository.  
Instead, you'll be creating a new project from scratch.  
And once you decide to work with Git on this project, you'll need to initialize a local Git repo.  

You do that by running the `git init` command.  
This will create a new local repo, which you can then configure to point to a remote repo.  