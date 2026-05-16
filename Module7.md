# Containers with Docker

## Module Overview

- What is a container? What problem does it solve?
- Container vs Image
- Container vs VM
- Main Docker commands
- Demo Project:
  - How to develop an application with containers?
  - Running multiple containers with Docker Compose
  - Building our own Docker image with a Dockerfile
  - Pushing our image to a private Docker repository
  - Deploying and running our containerized application
  - How to persist data in Docker with Volumes?
- Deploy and set up Nexus as a Docker container
- Create a private Docker repository on Nexus
- Push/fetch Docker images to/from that repository

## 1. What is a container?

A container is a way to package applications with all the necessary dependencies and configuration.  
The resulting package is a portable artifact, easily shared and moved around.  

A container has its own isolated OS layer, which is a Linux-based image most of the time.  
It also has a layer for the application code and its dependencies.  

### How it helps for developing applications

With containers, developers no longer have to set up the development environment on their machine.  
The container already includes everything that is needed to run and test the application.  

In order to run a containerized application, all you need is: 
- a container runtime 
- the container image, which can be downloaded from a repository such as Docker Hub

The host system doesn't matter anymore, a container will run the same on any machine (physical or virtual).  

This "new" paradigm also implies that we can run multiple versions of an application on the same machine without risking any conflict.   

### How it helps for deploying applications

No environmental configuration needed on the target server, except for Docker runtime.  
All there is to do is to run a docker command that pulls the container image from some repo and runs the application inside a container.  

### Other Containerization technologies

Docker is simply the most popular implementation of a container runtime.  
Other technologies include containerd, cri-o, etc.  

## 2. Container vs image

