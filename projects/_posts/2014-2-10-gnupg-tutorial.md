---
layout: post
title: GNU Privacy Guard Tutorial
---

[GnuPG](https://www.gnupg.org/){: .link} is one of the most widely distributed encryption tools. I've used [GPGTools](https://gpgtools.org/){: .link} before but I like being at the commandline and knowing what I'm getting. Something about going through the Mail application makes me think it can't possibly be secure. Anyways, I like to take notes when I try new things so here's a getting started for you.

Install with [Homebrew](http://brew.sh/){: .link}.

    brew install gnupg

Create a key pair

    gpg --gen-key

You can get a copy of the public key like this

    gpg -a --export "Name or email"

You can also publish your public key to a key server. First get the fingerprint of the key you want to export:

    gpg --fingerprint

Then send it off like this

    gpg --send-keys "fingerprint of your key"

If someone sent you their public key in a file, you and import it like this

    gpg --import pub.key

Or you can search for them on a public key server

    gpg --search-keys "name or email address"

To send a message, first write it up in a text file. Then you can encrypt it with their public key using ASCII armor, and signing it with your private key with the following

    gpg -e -a -s -r email message.txt

To decrypt the message, you simply use

    gpg message.txt.asm

Another cool think about GnuPG is that you can use symmetric encryption

    gpg -o doc.gpg -c doc