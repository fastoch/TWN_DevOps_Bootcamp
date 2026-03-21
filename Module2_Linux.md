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
Which means in case of hardware failure, you had to replace the entire server, reinstall applications, 
reconfigure the whole thing, and potentially risk losing critical data in the process depending on your backup policy reliability.  

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
>Modern Linux distributions maintain both /bin, /sbin, /lib and their /usr/ counterparts due to historical Unix 
>conventions and ongoing compatibility needs.

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
>Everything in Linux is a FILE, including directories, the devices we connect to our computer, 
>and the binaries we use when we run commands. 

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

https://github.com/fastoch/TWN_Linux_Commands/blob/main/README.md

---

## Installing software on a Linux distro

### What's a software package?

A compressed archive containing all files required by the software to run.  
Applications usually have dependencies, meaning they depend on other software.  

A software package does not necessarily include all needed dependencies, in which case the package manager will try 
and install the missing dependencies.  

### What's a package manager?

It's a tool that downloads and installs (or updates) software from a package repository.  
It also ensures the integrity and authenticity of downloaded packages before installation.  

For every package installation, it manages and resolves all required dependencies.  
And if those dependencies also have dependencies, it will install them too.  

When installing or updating software, your package manager knows where to put the different files in your Linux file system.  
And when you uninstall a software using your package manager, it knows where to find the files that need to be deleted.  

### Where do package managers come from?

Most Linux distros come with their own package manager:
- `apt` for Debian-based distributions = advanced package tool
- `dnf` for Fedora and other Red Hat-based distros = dandified yum
- `pacman` for Arch-based distros

To install a package on fedora: `sudo dnf install <package_name>`  
To remove it: `sudo dnf remove <package_name>`  

Your package manager fetches those packages from specific **repositories** (hosted online).  
On every Linux distro, there are default official repositories, to which you can add your favorite ones.  

Before installing or upgrading packages, it is recommended to update your package index.  
There is a specific command for that, and this command will pull the latest changes from the different 
repositories your distro is using.  

After you've updated your package index, your CLI will tell you how many packages can be upgraded.  
These are the packages for which were found newer versions in their respective repositories.  

On Fedora, the list of enabled repositories is stored as a set of .repo files under `/etc/yum.repos.d/`  
On Debian and Debian-based systems, it is stored under `/etc/apt/sources.list`  

Some packages are not available in the official repositories, in which case we need to add unofficial repos.  
Sometimes, they are available in official repos but not the latest version, because the software package 
approval process can take time.  

### Alternative to package managers

- many distros include **software centers** (GUI apps) such as Discovery or Ubuntu Software
- Under the hood, Ubuntu Software uses the **Snap** package manager (pre-installed on Ubuntu since 2016)
- There is another alternative called **Flatpak** (pre-installed on fedora since 2016)

You can check if you have flatpak via `flatpak --version`  
And you can see all installed flatpak packages via `flatpak list`  

### Wrapping up

Installing software on a Linux system can be done by:
- using the native package manager (the best option)
- using the Snap package manager
- adding a non-official repo and installing via the native package manager
- using a software centre GUI application
- using Flatpak 

---

## Working with Vim editor

### What is Vi/Vim?

**Vi** is a built-in text editor that is by far the most distributed and used on Linux systems.  
Depending on your Linx distro, its improved version, **Vim**, may be pre-installed.  
To check if that's the case, simply run `vi`. if it opens Vim, then you know.  

The Vi/Vim text editor is integrated into the CLI.  

### Why do we need a CLI text editor like Vim?

- It's a keyboard-centric editor, which makes you faster once you get used to it.  
- It's convenient to stay in the CLI rather than opening a dedicated text editor.  
- Some Linux systems, especially those installed on servers, may not include any other text editor than Vi/Vim.
- It allows you to create and edit files at the same time.
- Vim supports multiple file formats (syntax highlighting)

### How to edit a file in the CLI using Vim?

- to edit an existing file, or create and edit a new one: `vim filename`
- Vim has multiple **modes**, the **default** one being the **command** mode
  - in **command** mode, you can't edit text, but you can navigate the contents, search, delete, undo changes, etc.
  - to switch to **insert** mode, press `i`
  - in **insert** mode, you can edit text
  - to switch back to **command** mode, press `ESC`
  - to save the file and close it, type `:wq` while in command mode, and press `Enter`
  - to quit Vim without saving the changes, type `:q!` while in command mode, and press `Enter`

Example file to train on: `Learning_Vim.yaml`

### Vim commands

These commands are available in command mode:
- to delete a line: `dd`
- to delete 5 lines: `d5d`
- to delete a word: `dw`
- to undo changes: `u`
- to jump to the end of the line: `$`
- to jump to the end of the line and switch to insert mode: `A`
- to jump to the beginning of the line: `0`
- to jump to the the first character of the line and switch to insert mode: `I`
- to jump to the first line of the file: `1G`
- to jump to the third line: `3G`
- to jump to the last line of the file: `G`
- to search for a word: `/word`
  - press `Enter` to go to the first match
  - press `n` to go to the next match
  - press `N` to go to the previous match
- to search for a word and replace all occurrences of it: `:%s/old/new` + `Enter`

---

## Linux User Accounts & Groups

### 3 User Categories

- **The superuser (root)** account: has unrestricted access and permissions to the whole system
- **Regular user** accounts: those we create to log in to the system
  - each of them has its own dedicated space = home folder `/home/username`
- **Service user** accounts: relevant on Linux server distros
  - dedicated user accounts for a web service, a database service, a mailing service, etc.
  - each of these services has its own user account, which is good for security
  - you don't want to run services with the root user!

### Multiple users on a Linux server

When a team is managing a Linux server, they shouldn't be using the root user.  
Instead, each of them should have their own service account with a specific set of permissions.  
This is more secure and allows for traceability - being able to know who did what on the system.  

### Groups and permissions

#### How do we manage permissions for users on a Linux system?  

We can manage them on 2 different levels:
- we can give permissions to users directly (user level permissions)
- we can give permissions to groups of users (group level permissions)

Best practice is to use group level permissions:
- set permissions for a group
- add users to that group
- remove users from that group to remove corresponding permissions

### User management in practice

User accounts information is stored in the `/etc/passwd` file.  
Everyone can read it, but only the superuser can modify it.  

Each line in the `/etc/passwd` file is called a **user record**.  
The structure is: `username:password:uid:gid:gecos:home_directory:user_default_shell`  

The root user `uid` is 0.  
The `gid` is the primary group id.  

The `gecos` is the user's full name.  
The field was named after the **General Electric Comprehensive Operating System** (GECOS), 
which was a predecessor to the modern Unix systems.  

The password is represented by an `x`, it's encrypted and stored in the `/etc/shadow` file.  
When you display the contents of the `/etc/shadow` file, you'll see the hashed password, not the actual password.  

#### Adding a user

To add a user, we need to use the `adduser` command.  
The syntax is: `adduser username`  

This command will automatically choose policy-compliant uid and gid values.  
It will also create a home folder for the user, and you'll be asked to set its password.    

If you need more control over the user account creation process, you can use the `useradd` command.  

#### Changing a user's password

To change a user's password, we need to use the `passwd` command.  
The syntax is: `passwd username`  

This command will ask you to enter the new password twice.  
The password is encrypted and stored in the `/etc/shadow` file.  

#### Switching to another user

To switch to another user, we need to use the `su` command.  
The syntax is: `su - username`  

The dash simulates a full login, loading the target user's environment completely.  
The user will be asked to enter the password.  

To switch to the root user, we need to use the `su` command with the `-` option.  
The syntax is: `su -`  

To switch back to the previous user: `exit`

### Group management in practice

Groups information is stored in the `/etc/group` file.  
Whenever we create a user, the system also creates a group with the same name as the user.  

#### Adding a group

To add a group, we need to use the `groupadd` command.  
The syntax is: `groupadd groupname`  

#### Changing the primary group of a user

To change the primary group of a user, we need to use the `usermod` command.  
The syntax is: `usermod -g groupname username`  

The `-g` option specifies the primary group of the user.  

After changing a user's primary group, we can also delete the default group that was created automatically 
on user creation: `delgroup username`

#### Adding a user to multiple secondary groups

`usermod -aG group1,group2,group3 username`  
The `-G` option alone would overwrite the whole list of secondary groups.  
The `a` option appends the specified groups to the existing secondary groups.

#### Removing a user from a group

`gpasswd -d username groupname`

#### Check which groups a user belongs to

`groups username` or simply `groups` if already logged in as that user

### A word about adding users and groups

On most Linux distros, `adduser` and `addgroup` commands are interactive commands.  
They are more user-friendly than their non-interactive counterparts `useradd` and `groupadd`.  

With `useradd` and `groupadd`, you have more control but you need to provide the parameters manually.  

As a rule of thumb, use `useradd` and `groupadd` in scripts (automation), and use `adduser` and `addgroup` 
when executing them manually.  

The same goes for `userdel` and `deluser`, or `groupdel` and `delgroup`.  

---

## File ownership and permissions

### File Ownership

Each file has 2 different owners: a user and a group.  
After the permissions, the `ls -l` command displays the user who owns the file, and the group that owns it.  

The **owner** of a file is usually the user who created that file.  
And the **owning group** is the primary group of that user.  

### Changing the ownership of a file

The syntax is: `sudo chown <username>:<groupname> <filename>`  

To only change the owner of a file: `sudo chown <username> <filename>`  

To only change the owning group of a file: `sudo chgrp <groupname> <filename>`

### File permissions

Since everything in Linux is a file, user permissions are related to reading, writing and executing files.  

To display the permissions for a specific file, we need to use the `ls` command with the `-l` option.  
This will display the contents of a folder in a long listing format:
- The first digit represents the file type: 
  - `d` for directory, 
  - `-` for regular file, 
  - `l` for symbolic link
- After the file type, the permissions are represented by 3 sets of 3 digits:
  - The first set represents the owner's permissions (owning user)
  - The second set represents the owning group's permissions (members of that group)
  - The third set represents the other users' permissions (everyone else)
- In each set of permissions:
  - `r` stands for "read"
  - `w` stands for "write"
  - `x` stands for "execute"
  - `-` stands for "no permission"

### Modifying permissions

To modify permissions, we need to use the `chmod` command.  
There are many ways to change permissions in Linux.  

The first way (the most common) is by using an **octal** value.  
The syntax is: `sudo chmod <octal value> <filename>`  

The octal value is a number between 0 and 777, where each digit represents a permission:
- The first digit represents the owner's permissions, 
- the second digit represents the owning group's permissions, 
- and the third digit represents the other users' permissions.

Read permissions are represented by `4`, write permissions by `2` and execute permissions by `1`:  
- `rwx` = 7
- `rw-` = 6
- `r-x` = 5
- `r--` = 4
- `-wx` = 3
- `-w-` = 2
- `--x` = 1
- `---` = 0

---

We can also modify permissions in a more human-readable way.  
The syntax is: `sudo chmod <permissions> <filename>`  

For instance, `sudo chmod u=rwx,g=rw,o=r <filename>`, which is pretty self-explanatory and 
equivalent to an octal value of `764`.  

---

We could add or remove permissions globally with:
- `sudo chmod +x <filename>` = add execute permissions to the file for all users
- `sudo chmod -x <filename>` = remove execute permissions from the file for all users

Finally, we can add or remove permissions for specific users with:
- `sudo chmod u+x <filename>` = add execute permissions to the file for the owning user
- `sudo chmod g-x <filename>` = remove execute permissions to the file for the owning group
- `sudo chmod o+x <filename>` = add execute permissions to the file for other users

---

## Pipes and Redirects

### Standard Input & Standard Output

Every program has 3 built-in streams:
- Standard Input = STDIN (0)
- Standard Output = STDOUT (1)
- Standard Error = STDERR (2)

### Piping

The output of one command can become the input of another command.  
The syntax is: `command1 | command2 | command3`  

Using pipes `|` allows us to chain multiple commands, which is a very powerful feature of the Linux CLI.  

#### Piping into `less` 

For commands that have a long output, we can use the `less` command to scroll through the output page by page:  
`find -type f -name "*.log" | less`   

We can then press the `Space` key to display the next page, `b` to display the previous page, and `q` to quit.  
The last page is marked with `(END)`.  

`less` is also very convenient for displaying files that are too big to fit in the terminal.  

#### Piping into `grep`

To **filter** the output of a command, we can use the `grep` command:  
`find -type f -name "*.log" | grep host`  

grep = globally search for regular expression and print out  

We can search for multiple expressions, in which case we should use quotes:  
`history | grep "sudo dnf"`  

`grep` can help us find a specific file, but also search throught the contents of a file:  
`cat /etc/passwd | grep root`

#### Piping into `wc -l`

To count the number of lines in a command's output, we can use the `wc -l` command:
`find -type f -name "*.log" | wc -l`  
or  
`find -type f -name "*.log" | grep host | wc -l`

### Redirects

The `>` symbol is used to redirect the output of a command to a file.  
The syntax is: `command > filename`  
- If the file already exists, it will be overwritten.  
- If the file doesn't exist, it will be created.  

Example: `history | grep sudo > sudo_commands.txt`  

To avoid overwriting the contents of a file, we can use the `>>` symbol.  
The `>>` symbol is used to append the output of a command to the end of a file.  
The syntax is: `command >> filename`

---

## Introduction to Shell Scripting

The whole point of scripting is to:
- avoid repetitive work
- automate tasks (bulk operations)
- keep history of configuration

The idea is to:
- write commands in a file 
- then execute that script file

Such file is called a **shell script**.  
Shell scripts have a `.sh` file extension  

### Why the name "shell"?

On Unix-like systems, a shell is a program that interprets and executes the various commands that 
we type in the terminal. It translates our commands so that the OS kernel can understand them.  

### Different shell implementations

- Bourne Shell = /bin/sh - used to be the default shell (named after Stephen Bourne)
- Bourne Again Shell = /bin/bash - the current default shell on most Linux distributions
- **Fish** = /bin/fish - **friendly interactive shell** (my favorite one)
- many others...

Shell and Bash terms are often used interchangeably.  

- Bash is a shell program, a program that interprets and executes commands
- But it's also a programming language with which we can write shell scripts

Bash is an improved and more feature-rich version of the Bourne shell.  
But one advantage of using `/bin/sh` is that it's more universal and more likely to work on any Unix-like system.  

### How to write a Bash script?

We first need to create a file with a `.sh` file extension.  

#### shebang

But since all shell script files have the same `.sh` extension, how does the OS know which shell to use?  
We need to specify which shell we want to use at the very first line of our script:
- `#!/bin/bash` = Bourne Again Shell
- `#!/bin/sh` = Bourne Shell
- `#!/bin/zsh` = Z shell

That very first line is called a **shebang**.  

It's called "shebang" because of the first two characters:
- `#` = hash symbol = "sharp" in musical notation
- `!` = exclamation mark = also called "bang" 

The rest of the line is the path to the shell we want to use.  

---

#### Writing a shell script

After the shebang, we can open our script file and write our commands: `vim filename.sh`  
Once done, we can save and quit by typing `:wq` while in command mode.  

Example script files: `learning_Bash.sh`, `positional_param.sh`  

>[!tip]
>To skip lines, we can insert an empty `echo` between two lines.

### Executing a shell script

Once our script has been written, we can execute it by running `./filename`  
But at first, we'll get a "permission denied" error.  
That's because by default, when we create a new file, we don't have an execute permission on that file.  
To fix that, we need to use the `chmod` command: `chmod u+x filename`  

If you're using the fish shell, you can run your script using the bash command: `bash filename`  

### Variables

Very important concept in scripting.  
The idea is to store a value once and reference it multiple time throughout the script.  

The syntax is: `variable_name=value`  
There must be no spaces around the equal sign.  

To then reference this variable, we can use the `$` symbol: `$variable_name`  

We can also store the output of a command in a variable: `variable_name=$(command)`  

### if-else statements

```bash
if [ condition ]
then 
  command1
else 
  command2
fi
```

### Basic operators

#### File Test Operators (file conditions)

- `if [ -e filepath ]` = if file exists
- `if [ -d dirpath ]` = if file is a directory
- `if [ -f filepath ]` = if file is a regular file
- `if [ -r filepath ]` = if file is readable
- `if [ -w filepath ]` = if file is writable
- `if [ -x filepath ]` = if file is executable
- `if [ -s filepath ]` = if file is not empty (size > 0)
- `if [ -u filepath ]` = if file has its user id set
- `if [ -g filepath ]` = if file has its group id set

#### Number comparisons

Let's say we have an external variable named `"$num_files"` that stores the number of files in a directory:
- `if [ "$num_files" -eq 10 ]` = if number of files is equal to 10
- `if [ "$num_files" -gt 10 ]` = if number of files is greater than 10
- `if [ "$num_files" -lt 10 ]` = if number of files is less than 10
- `if [ "$num_files" -ge 10 ]` = if number of files is greater than or equal to 10
- `if [ "$num_files" -le 10 ]` = if number of files is less than or equal to 10

>[!important]
> in a Bash script, it's good practice to surround variable names with quotes
> This avoids word splitting and unintended behavior in case the value contains spaces or special characters

#### String comparisons

Let's say we have an external variable named `user_group` that stores the user's primary group:
- `if [ "$user_group" = "nana" ]` = if user_group is equal to "nana"
- `if [ "$user_group" != "nana" ]` = if user_group is not equal to "nana"
- `if [ "$user_group" =~ "nana" ]` = if user_group contains "nana"
  - The `=~` operator can be used to match regular expressions, not just strings
- `if [ -z "$user_group" ]` = if user_group is an empty string
- `if [ -n "$user_group" ]` = if user_group is not an empty string

>[!note]
> `==` is Bash specific, while `=` is POSIX standard 
> POSIX standard is compatible with all shell programs

### elif - else if

```bash
if [ condition1 ]
then 
  command1
elif [ condition2 ]
then 
  command2
else 
  command3
fi
```

### How to provide external values to a shell script?

#### Positional parameters

Arguments passed to a script are processed in the same order in which they are provided.  
Their indexing starts at 1.  
We can reference them from $1 to $9.  

Inside our script:
```bash
echo "$1"
echo "$2"
echo "$3"
```

On script execution:
```bash
./script.sh arg1 arg2 arg3
```

The main advantage of positional parameters is having a script that is configurable.  
Instead of hard coding all the values in the script, we can dynamically set them at runtime.  

---

### Reading user input

This is the other way to provide external values to a shell script.  

```bash
read -p "Enter a value: " value
echo "You entered: $value"
```

The -p option is used to prompt the user for input.  
The syntax is: `read -p "prompt" variable_name`  

See file `read_user_input.sh` inside the `shell_scripting` folderfor an example  
Obviously, this password example is not secure :smile:

### Shell Loops

How to accept any number of arguments?  
We can do that using loops.  

```bash
#!/bin/bash

echo "All params: $*" # prints out all arguments as a single string
echo "number of params: $#" # prints out the number of arguments
```

>[!important]
> A parameter is a **variable** that will receive a value when a function or a program is called.   
> An argument is the actual **value** that is passed into that function/program when it is called.  

There are 4 types of loops:
- while loops
- for loops
- until loops
- select loops

#### For loops

For loops enable us to execute some logic for every item in a list.  
Iterating through a list of values is a common use case for loops.  

```bash
#!/bin/bash

echo "all arguments: $*"
echo "number of arguments: $#"

for arg in $*
  do
    echo "$arg"
  done
```

The above example is very basic.  
Inside our for loop, we can add a conditional statement that checks if provided arguments are directories:
```bash
#!/bin/bash

echo "all arguments: $*"
echo "number of arguments: $#"

for arg in $*
  do
    if [ -d "$arg" ]
    then
      echo "$arg is a directory"
    else
      echo "$arg is not a directory or is not located in the current folder"
    fi
  done
```
This will print out the name of every argument that is a directory.  
For it to work, the directory needs to be located in the same folder as the script.  

#### While loops

A while loop executes some logic until a condition stops being true.  

```bash
balance=100
echo "your current balance is $balance$" 
echo "enter \"quit\" to exit the program"

while (( balance > 0 ))
  do
    read -p "enter a cost: " cost
    if [ "$cost" == "quit" ]
    then
      break
    fi
    (( balance-=cost ))
    echo "your balance is now $balance$"
  done

if [ "$balance" -le 0 ]
then
  echo "You don't have any money left"
fi
```

>[!tip]
>The `break` command can be used to exit a for|while|select|until loop

>[!note]
>For arithmetic operations, use the double brackets `(( ))` syntax.  
>For string operations, use the single brackets `[ ]` syntax. 

### Single square brackets vs Double square brackets

- POSIX: `[ ]`
- Bash: `[[ ]]`: more features but you lose portability

When using the double square brackets, you don't need to enclose the variable names in double quotes.  

### Bash vs Python

Bash scripting has quite a complex syntax which is not very intuitive.  
So, even though it is very useful in automating DevOps tasks, there are better alternatives such as:
- **Python** (programming language)
- **Ansible** (configuration tool)

We will learn both of these in the next modules.  
But the best engineer is the one who knows all tools available, and which one to use for a given situation.

### Functions

Functions are blocks of code that can be reused, it makes your code easier to read and maintain.  
The idea is to apply the DRY philosophy: Don't Repeat Yourself.  

If you know you're going to be using the same logic multiple times in your script (or in other scripts), 
then it's a good idea to create a function for that.  

The syntax to declare a function is:  
```bash
function_name() {
  list_of_commands 
}
```  

There are 2 steps to using functions:
1. Declaring a function
2. Invoking a function

Practical example of a function to which we pass arguments:
```bash
function print_info() {
  echo "name: $1"
  echo "age: $2"
  echo "email: $3"
}

# invoking the function (this one requires arguments)
print_info "John Doe" "30" "2Wf5t@example.com"
```

Example of a function that does not require arguments:
```bash
function sum() {
  read -p "Enter first number: " num1
  read -p "Enter second number: " num2
  echo "The sum of $num1 and $num2 is $(($num1+$num2))"
}

# invoking the function
sum
```

#### Best practices

- The function name should be a verb
- Don't use too many parameters
- A function should only do one thing

### Comments in Bash

To add a comment or comment out some code in a Bash script, we use the `#` character at the beginning of the line.  
This is useful to explain what a line of code does, or to disable a line of code without removing it.  

### Returning values from functions

Example:
```bash
function multiply() {
  read -p "Enter first number: " num1
  read -p "Enter second number: " num2
  result=$(($num1*$num2))
  # following line does not display the result, it just returns it
  return $result 
  # following line will never be executed since it is after the `return` instruction
  echo "The result is $result"
}

# invoking the function
multiply
# using the return value with $?
echo "The result is $?"
```

### Scripting Use Cases

Scripting is a very powerful skill which general purpose is to automate DevOps tasks.  

- Backup scripts
- Monitoring scripts
- Deployment scripts (deploying applications)
- Server Configuration scripts (infrastructure as code)
- ...

Scripts are portable and shareable files.  
They can be hosted on Git repositories for your team, or for your own personal needs. 

---

## Environment Variables

### What are environment variables?

Environment variables are variables that store information about the environment in which a program is running.  
They are used to store configuration settings, paths, and other information that can be accessed by a program.   

Environment variables can be set at the operating system level, or they can be set within a specific program or script.  

### What are they used for?

Environment variables are typically used to store information such as:
- Paths to directories, such as the location of executable files or libraries.
- Sensitive data, such as database authentication credentials or API keys.
- System-specific information, such as the user's home directory or the default login shell.

### Python example

Every programming language allows us to access environment variables.  
In Python, we can use the `os` module to access environment variables.  
The `os` module provides functions to interact with the operating system, such as getting environment variables.
```python
import mysql.connector

DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PWD")

mydb = mysql.connector.connect(
  host="https://prod-database:5432",
  user=DB_USER,
  password=DB_PASSWORD
)
```

### How to create|read|update|delete (CRUD) them from the CLI?

```bash
export DB_USER="username"
export DB_PWD="secretpwdvalue"
```

To check they were created: 
```bash
echo $DB_USER
echo $DB_PWD
```
OR
```bash
printenv | grep DB
```

To change their value:
```bash
export DB_USER="newusername"
```

To remove them:
```bash
unset DB_USER
```

### Persisting environment variables for the current user

When we set environment variables from the CLI, they are only valid for the current session.  
To persist them, we need to add them to the `~/.bashrc` file, which is located in every user's home directory.  

This is only valid if we're using the bash shell, but not the fish shell.  
Each shell has its own config file. For instance, the fish shell uses `~/.config/fish/config.fish`.  

The lines to add to your shell-specific config file are the same as the previous commands:
```bash
export DB_USER="username"
export DB_PWD="secretpwdvalue"
```

Once done, we can apply the new config by running `source ~/.bashrc` or `source ~/.config/fish/config.fish`  
This will load the new environment variables into the current shell session.  

### Persisting environment variables for all users

A `~/.bashrc` file is user-specific.  
To make env vars available for all users, we need to add them to some global config file located in the `/etc` folder.  

Not all Linux distros use the same file for system-wide environment variables.  
Most (Debian, Ubuntu, Fedora, Arch) support these core locations:
- `/etc/environment` or `/etc/environment.d`: shell-agnostic (simple KEY=value pairs)
- `/etc/profile` or `/etc/profile.d`: allows export and logic
- `/etc/<shell>rc` variants (`/etc/bash.bashrc` on Debian/Ubuntu).

### The PATH env var

It's a list of directories to search for executable files, separate by `:`.  
To display it: `env | grep ^PATH` or `echo $PATH`    
Example: `PATH=/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin`  

This global env var tells the shell which directories to search in for executable files in response to our executed commands.  

On Fedora Linux, the global `PATH` environment variable is primarily constructed and set across several 
system-wide configuration files, rather than a single definition point.  

### Adding a custom command/program

Let's write a simple program:
```bash
#!/bin/bash

echo "Welcome to Nana's DevOps Bootcamp $USER!"
```

Once we have it, we need to make it executable for all users:
```bash
chmod +x welcome.sh
```

We can then add our custom program to the `PATH` environment variable by adding it to the `~/.bashrc` file.  
- First, open the file: `vim ~/.bashrc`  
- Then add the following line at the bottom of the file:
```bash  
# appending our custom program location to the existing PATH
PATH=$PATH:/home/$USER/DevOps_Bootcamp/shell_scripting
```

Apply the changes by running `source ~/.bashrc`  

>[!note]
>Sourcing the ~/.bashrc file might require to first run `bash` to update the current shell's environment.

Also note that the PATH we've updated is the one that's used by the bash shell.  
If we want to use our program with the fish shell, we need to add its location to the PATH inside 
the `~/.config/fish/config.fish` file.  

Once done, we can run our custom program by typing `welcome.sh`.  
We don't need to be inside the `shell_scripting` folder to run our program, since we've added it to the `PATH`.  

Note that we didn't have to name our program `welcome.sh`, we could have simply named it `welcome`, similar to 
how native Linux commands are named (ls, cat, grep, etc.).

---

## Networking

### Basic networking concepts

- **LAN** = Local Area Network
- each computing device has a unique **IP address**
  - IP = Internet Protocol
  - devices communicate via these IP addresses
  - an IPv4 address is composed of 4 bytes (32 bits), separated by periods
    - bytes are also called octets
    - a byte can have a decimal value between 0 and 255 (a binary value between 00000000 and 11111111)
    - 1 bit = 0 or 1
    - 1 byte = 8 bits
  - The IPv4 address range goes from 0.0.0.0 to 255.255.255.255
- in a LAN, devices communicate via a **switch**
- **WAN** = Wide Area Network (composed of multiple interconnected LANs)
- in a WAN, devices located in different LANs communicate via a **router**
- The Internet is the ultimate WAN, composed of multiple interconnected WANs
- A router is what connects your computer to the Internet
- The IP address of a router is called a **gateway**

### Subnetting

- a subnet = IP address range = network IP address + subnet mask
- example: 192.168.0.0/24
  - 192.168.0.0 = network IP address
  - /24 = subnet mask = 255.255.255.0
  - in this subnet, IP address ranges from 192.168.0.0 to 192.168.0.255
  - which leaves 254 available addresses for devices
- example 2: 192.168.0.0/16
  - 192.168.0.0 = network IP address
  - /16 = subnet mask = 255.255.0.0
  - in this subnet, IP address ranges from 192.168.0.0 to 192.168.255.255
  - which leaves 65,534 available addresses for devices
- first address 192.168.0.0 is always the network's address, and last address is used for broadcasting

### internal and external IP addresses

When we send a request to an IP address within our LAN, the request goes to the switch which then forwards it 
to the destination device within the LAN, because a switch knows all addresses of all devices within the LAN.  

When we send a request to an external IP address, it will be forwarded to the Internet through a router.  

That means any device on a network needs 3 pieces of data to communicate with other devices: 
- IP address
- subnet mask
- gateway address

### Network Address Translation (NAT)

IP addresses within a LAN (a private network) are not visible to the outside world.  
When devices on our LAN send requests to a website, our private IP addresses are never shared with the destination server.  
Instead, they're replaced by the public IP address of our router before leaving our private network.  

That's why multiple LANs can use the same IP address range without risking any conflicts.  
And that's made possible by Network Address Translation (NAT).  

### Reverse NAT

Other devices on the Internet can reach our router by using its public IP address.  
Our router then forwards incoming requests to the appropriate device on our private network.  

But how does our router know which device to forward incoming requests to?  

When a device inside our network (e.g., 192.168.1.10:44321) sends a request out to the internet, the router:
- replaces the original source IP and port with its own public IP and an ephemeral port 
  (e.g., 203.0.113.1:10023 → 192.168.1.10:44321).
- remembers this mapping in a NAT state table (connection tracking table), associating the external 5‑tuple 
  (public IP, public port, destination IP, destination port, protocol) with the internal (private IP, private port).

When the reply comes back to the router’s public IP and that port, the router looks up the entry in this table and forwards the packet back to the correct private IP and port.

### Firewall (FW)

When we send a request to a server on the Internet, we will usually get a response back.  

But what if an outside device wants to talk directly to a device on our LAN?  
By default, this type of communication won't be allowed, it will be blocked by our firewall.  

A firewall is a **set of rules** that protects our network from unauthorized access.  

We define which device on our network (with a specific IP address) should be accessible.  
We can also define which external devices (or which IP addresses) should be allowed to access our network.  

We can say "I allow any device on the Internet to talk to my server".  
This is usually the case when we're running a web application.  

For most servers that are running some applications, we need to configure firewall rules to manage the access configuration.  

When defining these rules, we need to specify a **protocol** and a **port** number.  
Because the application running on our server will be listening on this specific port.  
It's listening for incoming requests, and serves responses to those requests.  

### Port Forwarding

Port forwarding is a technique used in network firewalls to allow incoming network connections to be routed to a specific device or service 
on a private network.  

To configure port forwarding on a firewall, you typically need to specify the following:
- external port
- internal port: port on which the service is running on your private network
- private IP address
- protocol: type of network traffic that should be forwarded (TCP or UDP)

### What is a port?

Every device has a set of ports, they're like doors to the same building.  
We can allow specific ports on our server to be accessed.  
Or we can allow specific ports to only be accessed by specific IP addresses.  

Different applications listen on specific ports.  
There are default or standard ports for many applications.   

For example, most web servers listen on port 80.  
MySQL databases listen on port 3306.  
PostgreSQL databases listen on port 5432.  

For every application, we need a port.  

### Domain Name System (DNS)

The Domain Name System (DNS) is a computer system that translates human-readable names into IP addresses.  
It's like a phone book for the Internet.  

Humans can't remember IP addresses, so we use URLs instead, such as https://github.com/fastoch.  
When we press enter to access a website, the browser sends a request to a DNS server which then finds the IP address 
of the server that is hosting the requested website.  

#### How does DNS manage so many addresses and their names?

All these names are divided into groups or **domains**.  
Domain names follow a hierarchical structure: 
- There are around 13 **root domains** across the world
- Under each root domain, we have **top level domains (TLDs)**
  - .com: commercial organizations
  - .mil: military applications
  - .edu: educational institutions
  - .org: non-profit organizations
  - .net: originally for networking technologies
  - .gov: governmental organizations

Apart from these original top level domains, there are geographical domains which were added later, 
such as .fr for France, .ca for Canada, etc.  

Finally, a bunch of other domains were also added like .biz, .dev, .int, etc.  

#### Domain Name Registration

When someone creates a website, they can buy a domain name like mywebsite.com.  
It's generally a yearly subscription, and if you don't need it anymore, someone else can buy it.  

But who manages these domain names? Who can sell them? Who keeps track of availability?  
It's all regulated by a dedicated organization called the **Internet Corporation for Assigned Names and Numbers (ICANN)**.  

The ICANN manages the TLD development and the architecture of the internet domain space.  
It also authorizes Domain Name registrars, which register and assign domain names.

#### How does DNS resolution work?

Every computer has a DNS client pre-installed.  
When you open a web browser and type in a URL, your OS makes a DNS query asking a DNS server to resolve that URL to the correspondng IP address.  

The DNS request first goes to your local name server, which is typically operated by your ISP (internet service provider).  
This DNS server might already have the IP address stored in its cache.  
If not, it will go through one of the 13 root DNS servers.  

---

## SSH - Secure Shell



---
End of Module 2