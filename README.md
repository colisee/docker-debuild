# docker-debuild

## Introduction
The goal of this container is to provide a debian sid environment on which a maintainer can run packaging activities, such as:
- Grabbing files over the network with `curl`
- Preparing debian packages with `debmake`
- Modifying package-related files with `nano`
- Packaging software with `debuild`
- Recording bug issues with `reportbug`

## Instructions
1. Import the docker image into your host
   ```
   docker pull colisee/docker-build:latest"
   ```
1. Create file `env.list` with the following content:
   ```
   DP_EMAIL="your_email_address"
   DP_FULLNAME="first_name last_name"
   DP_GPGKEYID="your_GPG_key-id"
   ```
1. Start the container
   ```
   docker run -it --env-file env.list -v "${HOME}/.gnupg:/root/.gnupg" -v "debian_package_directory_on_host:/mnt" colisee/docker-debuild:latest
   ```
1. Inside the container, go to the `/mnt` directory and perform your packaging activities
