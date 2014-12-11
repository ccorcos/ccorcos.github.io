---
layout: post
title: Raspberry Pi Setup
---

I have a few Raspberry Pi's now, but my favorite thing to do with them is hardwire them to the ethernet run cron jobs. So I thought I'd give a quick introduction on how to setup your Pi.

## Setup

After installing Raspian on your SD card and booting up your Pi, its helpful to install the [avahi-daemon](http://en.wikipedia.org/wiki/Avahi_(software)){: .link} so you can ssh into your Pi over your local network without knowing the IP address.

    $ sudo apt-get update
    $ sudo apt-get upgrade
    $ sudo apt-get install avahi-daemon

Now you can ssh into your Pi using the hostname.

    $ ssh pi@raspberrypi.local

If you're me, you'll add an alias to your `.bashrc` (not on your Pi stupid!).

    alias pi="ssh pi@raspberrypi.local"

I also like using Vim because I'm most familiar with it. But you have to install it!

    $ sudo apt-get install vim
    $ echo "set nocompatible" > ~/.vimrc
    $ echo "export VISUAL=vim" > ~/.bashrc
    $ echo "export EDITOR=$VISUAL" > ~/.bashrc

And because almost all scripts I run on my Pi using Python, the pip package manager is incredibly useful.

    $ sudo apt-get install python-pip

## Cron Jobs

Cron jobs are awesome. They allow you to schedule scripts to run at a certain time.

Setting up a cron job on your pi is pretty easy. All the cron jobs on your computer are listed in a single file. The format of the file is [explained pretty well here](http://www.raspberrypi.org/documentation/linux/usage/cron.md){: .link}.

To edit the cron jobs, use the following command.

    $ crontab -e

There are all kinds of fun and useful things you can do with this. For example, you can user my [Craigslist Watch](https://github.com/ccorcos/craigslist-watch){: .link} program to parse through apartments on craigslist every day and send you an email with the results.

    # Craigslist Script
    0 18 * * * cd /home/pi/programs/craigslist-watch/ && python craigslist.py

Note that its a good idea to `cd /path/to/dir/ && python program.py` just in case your program is importing any files from the same directory.

You can also setup an [internet speed logger that tests your internet speed every hour](https://github.com/ccorcos/internet-speed-log){: .link}. This way, you can call up your internet service provider and get your internet bill prorated for the sluggish internet speeds below their quoted rate!

    # Speedtest
    0 * * * * cd /home/pi/programs/internet-speed-log/ && python speedtest.py

Or you could setup a cron job to [check-in to your Southwest Airlines flight exactly 24 hours before the flight so you get an A boarding pass](https://github.com/ccorcos/southwest-checkin){: .link}.

    # Southwest Check-in Script
    20 14 19 04 * cd python /home/pi/programs/southwest-checkin/checkin.py Chet Corcos G78ZOV ccorcos@gmail.com

But wait, make sure you setup your timezone so these run at the correct time!

    $ sudo raspi-config

Go to internationalization options > timezone and set it to your timezone. Now you're good to go! Have fun, and let me know of any awesome cron jobs your set up on your Raspberry Pi!

If you are having any trouble and it seems the jobs aren't running as you'd expect them to, then check out the logs.

    $ cat /var/log/syslog
