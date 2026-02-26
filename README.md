# Intro

These are my notes from learning the DevOps engineer profession thanks to Nana Janashia's DevOps Bootcamp.

---

# Operating Systems & Linux Basics (module 2/16)

## What Operating Systems are for?

OS are acting as intermediaries between applications we use (software) and physical components (hardware).

## Virtualization

Virtualization removes the need for physical hardware to install and run an OS.  
You can install any OS on top of any other OS thanks to something called a hypervisor.  

A hypervisor is a technology that allows hosting multiple virtual computers on a physical computer.  
It uses physical resources (CPU, RAM, storage, I/O devices) to create virtual machines (VMs).  

VMs, even if running on the same host system, don't see each other, they're completely isolated.  
And if something breaks inside a VM, it does not affect the host system.  
Plus, it's very easy to delete the faulty VM and spin up a new one; with snapshots we can even create the exact same one.  

### Benefits of using VMs

- you don't need to buy a new computer
- it's ideal to learn and experiment
- you don't endanger your main OS
- you can test your app on a specific OS

### Type 2 Hypervisor

This type of hypervisor is installed on an existing OS that runs on a physical machine.  
One of the most popular Type 2 hypervisors is VirtualBox.  

Hardware > Host OS > Type 2 Hypervisor > VMs (Guest Operating Systems)  

Type 2 hypervisors are typically used on Personal Computers.

### Type 1 Hypervisor

This type of hypervisor is installed directly on a physical machine, it does not require an OS to run on.  
It is called a "**bare metal**" hypervisor.  
Most populare type 1 hypervisors are VMware ESXi and Microsoft Hyper-V.  

Hardware > Type 1 Hypervisor > VMs  

Type 1 hypervisors are typically used on big **servers**.  
Big companies and Cloud providers use this type of hypervisors.  
For example, when we create an EC2 instance on **AWS**, a type 1 hypervisor installed on a big physical server will spin up a VM for us.  

**Note**: both type 1 and type 2 hypervisors need to access hardware resources, but type 2 do it through an OS.  

### Why do cloud providers and large companies use VMs?

- Efficient usage of hardware resources
- users can choose resource combinations that fit their needs
- Abstraction of the OS from the hardware

That last benefit is very important, because before virtualization, the OS was tightly coupled to the hardware it was running on.  
Which means in case of hardware failure, you had to replace the entire server, reinstall applications, reconfigure the whole thing, and potentially 
risk losing critical data in the process depending on your backup policy reliability.  

With virtualization, you have your server as a portable file that you can move around = a Virtual Machine image.  
This VM image contains the OS, all the applications, the required configuration, and all the data you want to store on your server.  

And since it's a file, you can easily make copies of it = snapshots.  
These snapshots can then be used on any computer that has enough resources to run them and a compatible hypervisor.

---

## Linux File System vs Windows'

Linux File System has a hierarchical tree structure.  
We have one root folder which contains all other folders and files.  

In comparison, the Windows file system does not have one root folder where all the folders stem from.  
It rather has multiple root folders.  
When PCs only had insertable floppy disks, Windows used letters to assign drives for each insertable disk slot.  
Letters A and B were used for removable disks, and Windows used C: when internal hard drives appeared.   

### Linux File System Overview

Every user on Linux gets its own personal folder, which is located in `/home/username`, also accessible via `~`.  
Some default directories are created for each user, such as Documents, Desktop, Pictures...

The root user is the only user that doesn't have its own folder in `/home`, instead it's located in `/root`.  

- `/bin`: stands for binaries, contains executables for most essential commands (cat, cp, ls, echo...)
  - these binaries are available system-wide (for all users but also for the system itself)
  - a binary is a computer-readable format (zeros and ones)
- `/sbin`: contains system binaries, executables that require root permissions or the use of `sudo`
- `/lib` folders: contain essential shared libraries that executables from /bin or /sbin use
- `/usr`: the actual location of binaries and libraries. In most cases, previous folders are symlinks 

>[!note]
>Modern Linux distributions maintain both /bin, /sbin, /lib and their /usr/ counterparts due to historical Unix conventions and ongoing compatibility needs.

- `/usr/local`: also contains /bin, /sbin, and /lib folders. This is where the applications we install will be located.
  - will contain third-party apps such as docker, python, minikube, ...
  - programs installed here will be available for all users on the computer
  - this folder is for programs that split their files across multiple subfolders
- `/opt`: third-party apps can also be installed here
  - but it's a folder for apps that do not split their files across different folders
  - programs installed here will also be available for all users (system-wide installation)
- `/boot`: contains files required for booting, only used by the system itself
- `/etc`: main configuration location
- `/dev`: This is where the devices that are connected to your computer will be stored: mouse, keyboard, drives, etc.
- `/var`: files to which the system writes data during the course of its operation
  - `/var/log`: contains log files
  - `/var/cache`: contains cached data from applications
- `/tmp`: stores temporary resources required for some processes
- `/media`: contains subfolders where removable media devices inserted into the computer are automatically mounted
- `/mnt`: used for temporary mount points, typically for manually mounting a file system to the OS

### Hidden Files

Hiding files is primarily used to help prevent important data from being accidentally deleted.  
These files are automatically generated by programs or by the OS, and they start with a dot `.`.  
That's why in Unix-like operating systems, hidden files are also called "**dotfiles**".  

---

## Basic Linux commands

>[!tip]
>To save time when typing commands, take advantage of **autocompletion** by using the **Tab** key.

### Directory operations

- `pwd` = print working directory
  - `~` is the same as `/home/username`
- `ls` = list the contents of the current directory
- `ls <dirname>` = list the contents of the specified directory
  - typically used with options such as `ls -alSh` (hidden files, long format, sorted by size, human-readable)
- `ls -R <dirname>` shows the contents of the specified directory and of all its subdirectories
- `cd <path_to_directory>` = change working directory
  - `cd` brings you back to your home folder
  - `cd ..` brings you to the parent folder (one level up)
  - `cd ../..` brings you two levels up in the tree structure
- `mkdir <dirname>` = make directory
- `rmdir <dirname>` = remove an empty directory
- `rm -r <dirname>` = remove a non-empty directory and all the files within it (`-r` is for recursive)

### File operations

>[!important]
>Everything in Linux is a FILE, including directories, the devices we connect to our computer, and the binaries we use when we run commands. 

- `touch <filename>` = create a file
- we can also create files using an editor: `nano <filename>` or `vim filename`
- `rm <filename>` = remove file
- `mv <filename_or_path> <new_filename_or_new_path>` = move a file or rename it, or both
- `cp <source_path> <destination_path>` = copy a file (the name of the copy can be different from the original)
  - if you're copying a non-empty folder: `cp -r <source> <destination>`
- `cat <file>` shows the contents of a file in the stdout (standard output)

### Terminal shortcuts

- Ctrl + Alt + T = open a new terminal window
- Ctrl + L = bring the cmd prompt at the top
- Ctrl + C = stop the running command
- Ctrl + Shift + V = paste copied text into terminal
- Ctrl + Shift + C = copy selected text from terminal
- Ctrl + D = close the terminal window
- Ctrl + E = go to the end of the command line
- Ctrl + A = go to the beginning of the command line
- Ctrl + U = delete the current line, requires the cursor to be at the end of the line
- Ctrl + W = delete the word located before the cursor
- Ctrl + R = search through your command history
- use the up and down arrow keys to navigate through your command history

### Executing commands as a super user

Use `sudo` before typing your command (requires to be part of the "wheel" or "sudo" group).  
To find which groups a user is a member of: `cat /etc/group | grep username`.  

To switch to another user: `su - username`  
The dash simulates a full login, loading the target user's environment completely.

---

## More advanced commands

https://github.com/fastoch/TWN_Linux_Commands/edit/main/README.md

---

## Installing software on a Linux distro

### What's a software package?

A compressed archive containing all files required by the software to run.  
Applications usually have dependencies, meaning they depend on other software.  

A software package does not necessarily include all needed dependencies, in which case the package manager will try and install the missing dependencies.  

### What's a package manager?

It's a tool that downloads and installs (or updates) software from a package repository.  
It also ensures the integrity and authenticity of downloaded packages before installation.  

For every package installation, it manages and resolves all required dependencies.  
And if those dependencies also have dependencies, it will install them too.  

When installing or updating software, your package manager knows where to put the different files in your Linux file system.  
And when you uninstall a software using your package manager, it knows where to find the files that need to be deleted.  

### Where do package managers come from?

Most Linux distros come with their own package manager:
- apt for Debian-based distributions = advanced package tool
- dnf for Fedora and other Red Hat-based distros = dandified yum
- pacman for Arch-based distros

To install a package on fedora: `sudo dnf install <package_name>`

---

# 3. Version Control with Git (module 3/16)

