---
layout: post
title:  "Deploying a Meteor Webite"
---

# Deploying a Meteor Website

First off, configuring your domain to point to your deployment is discussed in [another post](/blog/dns).

This post will discuss:

- Running Locally
- Deploying to meteor.com
- Deploying to Digital Ocean with `mup`
- Deploying to Bithost with `mup`
- Deploying to Heroku
- Managing your server

# Running Locally
First off, some notes about running Meteor locally. `meteor` or `mrt` will run your application on localhost. You can access this website from your mobile phone or another computer by typing in the local IP address of the computer with the correct port. Go to system preferences, network and you'll find it. For example, `10.0.1.77:3000` would work for me right now with an app running on `localhost:3000`.

To reset the database, you can run `meteor reset`, or you can do it though mongo. To access the mongo shell for your website running locally, simply run `meteor mongo`. If you defined a collection in JavaScript `Posts = new Meteor.Collection("posts")`, you can access this collection through the mongo shell with `db.posts.find()`. Note that there is no need to fetch! To reset the database from within mongo, you can run `db.dropDatabase()`. This will also drop gridFS collections as well. So if you are storing files on the filesystem, you need to handle those separately. Also, to list all the database collections, run `db.getCollectionNames()` from the mongo shell.

# Deploying on Meteor
The easiest way to deploy a website is on [Meteor's infrastructure](http://docs.meteor.com/#deploying). Simply use `meteor deploy myapp.meteor.com` and the site will be live immediately. Also be sure to [claim your app subdomain](https://www.meteor.com/account-settings) with your meteor account so no one else can overwrite it! You can also have your own domain name point its CNAME to this meteor website so you can simply run `meteor deploy www.myapp.com`. Check out how to do this [in another post](/blog/dns).

To access the mongo database you can simply use `meteor mongo myApp.meteor.com`. To access server logs, use `meteor logs myApp.meteor.com`.

# Deloying to Digital Ocean

Go to [Digital Ocean](https://www.digitalocean.com/) and create a droplet. They have a $5 minimum plan. Name the hostname something reasonable.

Set up your droplet to Ubuntu or Ubuntu with Node.js already installed (this will have effects on your `mup` configuration).

To ssh into your server, you can simply use:

ssh root@<droplet_IP_Address>

At this point, you may want to create a subdomain, or point the A record of your domain name to this IP address. You can find more about that [in another post](/blog/dns). For the sake of this example, we'll stick with the IP address, but this address could be replaced with the domain name.

To deploy your app to this server, we'll use meteor up, also known as `mup`. First, create an empty directory to configure your deployment. You dont want this to be in your Meteor project directory because this will contain passwords. In that directory, run `mup init`. Open up `mup.json` and set it like like so:

{
  // Server authentication info
  "servers": [{
    "host": "<droplet_IP_Address>",
    "username": "root",
    "password": "<root password was emailed to you>"
    }],

    // Install MongoDB in the server, does not destroy local MongoDB on future setup
    // "setupMongo": true,

    // WARNING: Node.js is required! Only skip if you already have Node.js installed on server.
    "setupNode": false,

    // WARNING: If nodeVersion omitted will setup 0.10.25 by default. Do not use v, only version number.
    // "nodeVersion": "0.10.29",

    // Install PhantomJS in the server
    "setupPhantom": true,

    // Application name (No spaces)
    "appName": "meteor",

    // Location of app (local directory)
    "app": "/path/to/meteor/app",

    // Configure environment
    "env": {
      "ROOT_URL": "http://mydomain"
      },

      // Meteor Up checks if the app comes online just after the deployment
      // before mup checks that, it will wait for no. of seconds configured below
      "deployCheckWaitTime": 15
    }

    If your selected your server to have node pre-installed, you can set `"setupNode": false`. Don't forget to set `nodeVersion` to the most recent!

    Before deployment, you'll want to run `mup setup` to install the appropriate configuration on the server. Then to deploy your app, simply run `mup deploy`.

    After ssh'ing into your server, to access mongodb, you can run `mongo appName` which is setup in `mup.json`, the default is `mongo meteor`.

    You can access live server logs using `mup logs -f`.

    # Deploying to Bithost.io
    The glory of [Bithost](https://bithost.io/) is that you can pay with bitcoins to conceal your identity. I would highly recommend reading about [hiding your identity](/blog/hide) if that's what you're interested in. For Bithost, you'll have to upload an ssh key to create a server - you will never be given a root password. There are some more detailed instructions on how to do this [here](https://help.github.com/articles/generating-ssh-keys), but its rather simple.

    $ cd ~/.ssh
    $ ssh-keygen -t rsa -C "<your_email@example.com>"
    Generating public/private rsa key pair.
    Enter file in which to save the key (/Users/<your_user>/.ssh/id_rsa): /Users/<your_user>/.ssh/<name>_rsa
    Enter passphrase (empty for no passphrase):
    Enter same passphrase again:
    $ pbcopy < ~/.ssh/<name>_rsa.pub

    Since you're probably using Bithost to conceal your identity, be sure to use a VPN when accessing bithost and generate a new key with an anonymous email address! You'll probably want to create a separate ssh identity as well (other than the default id_rsa). `pbcopy` will copy the public key to your clipboard so simply paste it to bithost.

    Set up your droplet to Ubuntu or Ubuntu with Node.js already installed (this will have effects on your `mup` configuration).

    To ssh into your server, you can simply use:

    ssh -i ~/.ssh/<name>_rsa root@<droplet_IP_Address>

    Its convenient to create an alias and put it in your `~/.bash_profile`:

    alias server="ssh -i ~/.ssh/<name>_rsa root@<droplet_IP_Address>"

    Alternatively, you could just setup an ssh config file: If it doesn't already exist, create a config file `touch ~/.ssh/config`.

    Host <IP or domain>
    HostName <IP or domain>
    User root
    IdentityFile ~/.ssh/<name>_rsa

    Now you can simply run `ssh www.domain.com` or `ssh root@<IP address>`.

    At this point, you may want to create a subdomain, or point the CNAME of your domain name to this IP address. You can find more about that [in another post](/blog/dns). For the sake of this example, we'll stick with the IP address, but this address could be replaced with the domain name.

    To deploy your app to this server, we'll use meteor up, also known as `mup`. First, create an empty directory to configure your deployment. You dont want this to be in your Meteor project directory because this could (but won't) contain passwords. In that directory, run `mup init`. Open up `mup.json` and set it like like so:

    {
      // Server authentication info
      "servers": [{
        "host": "<droplet_IP_Address>",
        "username": "root",
        "pem": "~/.ssh/<name>_rsa"
        }],

        // Install MongoDB in the server, does not destroy local MongoDB on future setup
        // "setupMongo": true,

        // WARNING: Node.js is required! Only skip if you already have Node.js installed on server.
        "setupNode": false,

        // WARNING: If nodeVersion omitted will setup 0.10.25 by default. Do not use v, only version number.
        // "nodeVersion": "0.10.29",

        // Install PhantomJS in the server
        "setupPhantom": true,

        // Application name (No spaces)
        "appName": "meteor",

        // Location of app (local directory)
        "app": "/path/to/meteor/app",

        // Configure environment
        "env": {
          "ROOT_URL": "http://mydomain"
          },

          // Meteor Up checks if the app comes online just after the deployment
          // before mup checks that, it will wait for no. of seconds configured below
          "deployCheckWaitTime": 15
        }

        If your selected your server to have node pre-installed, you can set `"setupNode": false`. Don't forget to set `nodeVersion` to the most recent!

        Before deployment, you'll want to run `mup setup` to install the appropriate configuration on the server. Then to deploy your app, simply run `mup deploy`.

        After ssh'ing into your server, to access mongodb, you can run `mongo appName` which is setup in `mup.json`, the default is `mongo meteor`.

        You can access live server logs using `mup logs -f`.

        # Deploy on Heroku

        I used to use [Heroku](https://www.heroku.com/) because its free under a certain amount of data/bandwidth.

        First thing you need to do is [download the Heroku Toolbelt (commandline tools)](https://devcenter.heroku.com/articles/quickstart) and follow the getting started instructions to create you website Dyno. We will be using the [Meteor-Heroku build pack](https://github.com/jordansissel/heroku-buildpack-meteor) or actually the [Meteorite-Heroku buildpack](https://github.com/oortcloud/heroku-buildpack-meteorite) to upload our Meteor website onto Heroku.

        You need to make sure you have a git repo for your website already. If not:

        git init
        git add .
        git commit -m "initial commit"

        Now, log into Heroku through the commandline:

        heroku login

        Lets create a Meteorite app with Heroku called `chetcorcos` using the buildpack:

        heroku create chetcorcos --stack cedar --buildpack https://github.com/oortcloud/heroku-buildpack-meteorite.git

        Then add mongo, root url, and domains to your dyno:

        heroku addons:add mongohq:sandbox
        heroku config:add ROOT_URL=http://chetcorcos.herokuapp.com/
        heroku domains:add www.chetcorcos.com

        Be sure to point your DNS CNAME here. More information on this [in another post](/blog/dns).

        Finally, you can push your git repo to Heroku to run the app:

        git push heroku master

        There you go! From now on, if you edit your webite, you git push to Heroku to update it. If you want to start from scratch and replace an old repo, you have to delete the Heroku app from online and recreate it using the create command from above. If the deployment isnt working and you want to clean up your git repo of all this Heroku nastiness, all you need to do is:

        git remote rm heroku

        I don't user heroku anymore so I'm not sure about ssh'ing and the rest, but I'm sure you can find all that online somewhere.

        #Mongo Backups#

        The easiest way to backup mongo is with [`mongodump` and `mongorestore`](http://docs.mongodb.org/manual/tutorial/backup-with-mongodump/).

        Here's my process:

        SSH into your server. `cd` to where you want your dump to be. Then run `mongodump -d appName` where the appName is by default `meteor` with `mup`. This creates a `dump/appName/` folder with the database backups.

        To restore mongo from your backup, you can use `mongorestore -d appName /path/to/dump`.

        In the end, the two commands you'll likely use are:

        mongodump -d meteor
        mongorestore -d meteor dump/meteor

        These backups also backup files saved with gridFS.

        Lastly, you may want to copy the backups to and from your local computer for safe keeping. To get it your local computer, from your local terminal, run:

        scp -r <domain or root@IP_Address>:/path/to/backup/folder /path/to/local/dir/to/save

        To upload a backup from your local computer, run:

        scp -r /path/to/local/dir/ <domain or root@IP_Address>:/path/to/remote/dir/to/save

        In the end, after setting up your DNS, and creating a `/root/backups` folder on your server, you will use these two commands:

        scp -r www.myApp.com:/root/backups/1-1-2014 .
        scp -r backups/1-1-2014 www.myApp.com:/root/backups/1-1-2014


        #SSH Keys#

        To give someone else ssh access to your server, you'll want to add their public key to `~/.ssh/authorized_keys` in a new line on the server.
