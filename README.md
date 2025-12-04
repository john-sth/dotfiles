# Dotfiles for a Debian-based System

- This setup is based on https://effective-shell.com/part-5-building-your-toolkit/

## TODO

- [ ] write shell.sh script 


# My dotfiles

This directory contains the dotfiles for my system

## Requirements

### Stow

Arch: 
```
pacman -S stow
```

Debian: 
```
apt-get install stow
```

## Installation

```
$ git clone git@github.com:john-sth/dotfiles.git
$ cd dotfiles
```

then use GNU stow to create symlinks

```
$ stow .
```
