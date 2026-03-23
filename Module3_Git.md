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
- 