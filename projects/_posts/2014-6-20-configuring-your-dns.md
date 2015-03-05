---
layout: post
title: Configuring Your DNS
---

I had a lot of frustration trying to figure out how to configure my domain name correctly. I eventually realized that the customer support at GoDaddy had no idea what they were doing, so I had to figure things out myself. Here's what I learned. There are basically 3 different solutions depending on your need.

Forwarding is quick and dirty. This setup will simply redirect to the appropriate domain. However, it is not the most elegant solution and I wouldn't recommend it. If GoDaddy servers go down, that means your website is not accessible even if your website is not hosted on GoDaddy's servers. The more elegant solution is to use the DNS Zone File. Setting the DNS Zone File will entirely skip over GoDaddy's servers. The only downside of this approach is that it will take up to an hour for the changes to propagate throughout web.

There are two different ways of setting up you're DNS Zone File depending on you're needs. If you need to point your domain name to an IP address, you'll want to set the "A (host)" record. If you need to point your domain name to another domain, for example `something.meteor.com`, `something.herokuapp.com`, or `username.github.io`, you'll want to set the "CNAME (alias)".

<!-- There is a special character, "@", which refers to the domain itself with A prefix. If you want to setup a subdomain, you can simply setup the host to be the subdomain prefix you want. -->
