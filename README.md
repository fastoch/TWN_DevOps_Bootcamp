# Intro

These are my notes from learning the DevOps engineer profession thanks to Nana Janashia's DevOps Bootcamp.

# Operating Systems & Linux Basics (module 2/16)

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

### Type 1 Hypervisor

This type of hypervisor is installed directly on a physical machine, it does not require an OS to run on.  
It is called a "bare metal" hypervisor.  



## Linux File System vs Windows'

Linux File System has a hierarchical tree structure.  
We have one root folder which contains all other folders and files.  

In comparison, the Windows file system does not have one root folder where all the folders stem from.  
It rather has multiple root folders.  
When PCs only had insertable floppy disks, Windows used letters to assign drives for each insertable disk slot.  
Which is why A and B were used for removable disks, and they used C: when internl hard drives appeared.   

## Linux File System Overview

