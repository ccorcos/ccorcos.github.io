---
layout: post
title: Mac Development Setup
---

Every year, when the new OS X operating system comes out, I like to do a clean install, getting rid of all the junk on my computer that accumulated over the past year. Over the years, I've created some scripts to help me automate the process of setting up my new machine the way I like it. [I've create a repository on my Github elaborating on this process and providing some useful scripts](https://github.com/ccorcos/mac-setup){: .link}.

There are a few things you have to do manually first. You'll need to install the Xcode commandline tools which you can do directly from the commandline without installing Xcode.

    $ xcode-select --install

Next, you'll want to install any apps you have already purchased from the App Store. You'll probably want to install Xcode anyways.

## Homebrew

Then you'll want to install [homebrew](http://brew.sh/){: .link}, a commandline tool to manage installations on your Mac. Checkout my [`install.sh`](https://github.com/ccorcos/mac-setup/blob/master/install.sh){: .link} script which install homebrew, various applications and some python modules.

## Zsh

Zsh (Z shell) is a modern shell with a handful of perks. Among others, it has excellent fuzzy-autocomplete. [I have also forked the amazing Prezto configuration framework to version control my own zsh settings here](https://github.com/ccorcos/prezto){: .link}. This gives you some great perks like `cat` syntax highlighting, command highlighting for valid and invalid commands, and git status icons. To get started, install zsh through brew.

    $ brew install zsh

Then open zsh, don't worry about the initial configuration it asks you for.

    $ zsh

Then [follow the instructions here](https://github.com/ccorcos/prezto){: .link} to clone and symlink all the resource files and finally, set your default shell to zsh.

    $ chsh -s /bin/zsh

## Atom Editor

I prefer to use the [Atom Editor](https://atom.io/){: .link} as opposed to Sublime Text because it is open source and offers a huge amount of configuration. You can get setup with my atom settings by running my [`setup_atom.sh`](https://github.com/ccorcos/mac-setup/blob/master/setup_atom.sh){: .link} script, or simply the following.

    $ brew cask install atom
    $ git clone https://github.com/ccorcos/atom-editor-settings.git ~/.atom

This gives you a slew of amazing packages and themes.

## OSX Defaults

I also have a [script to setup some default preferences here](https://github.com/ccorcos/mac-setup/blob/master/osx_defaults.sh){: .link}. I suggest you go through one-by-one and comment out lines to suit your taste. Many of these settings cannot be configured through System Preferences like adding spacers to your dock. You may have to restart your computer for some of these configurations to take place.
