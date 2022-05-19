# docker-debuild

## Introduction
The goal of this container is to provide a lite debian environment where you can can perform packaging activities, such as:
- Recording bug issues with `reportbug`
- Grabbing files over the network with `curl`
- Preparing debian packages with `debmake`
- Modifying package-related files with `nano`
- Building and signing your debian package(s) with `debuild`
- Pushing your debian package(s) on menors.debian.net with `dput`
- Running exceptionally root-related tasks with `sudo`

## Instructions
1. Adapt file `list.env`:
1. Define the path of your debian package directory as follows:
   ```
   DEB_PKG=path_to_your_debian_package_on_your_host"
   ```
1. Run the container
   ```
   docker run \
      --interactive \
      --tty \
      --rm \
      --env-file list.env \
      --volume "${HOME}/.gnupg:/home/maintainer/.gnupg" \
      --volume "${HOME}/.ssh:/home/maintainer/.ssh" \
      --volume "${DEB_PKG}:/home/maintainer/package" \
      colisee/debuild
   ```
1. Once inside the container:
   - you are user `maintainer` 
   - go to the `$HOME/package` directory and perform your packaging activities
