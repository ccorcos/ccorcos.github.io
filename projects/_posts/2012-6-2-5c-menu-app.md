---
layout: post
title: 5C Menu iPhone App
---

At the Claremont Colleges, pretty much everyone eats at the dining halls all four years. My freshman year, I had the idea of putting creating an iPhone app for the dining hall menus. That summer, I tried and failed. In fact, the following summer I tried and failed yet again. Then, my junior year at Harvey Mudd, I started to figure it out. Objective-C and its incredibly object-orientated nature was totally foreign to me. At this point, I had only taken an introductory computer science course.

I implemented this app using Google App Engine (GAE) to run a python script that parses the dining hall menus periodically, formatting the data into XML and JSON. I used python because there is an awesome library called Beautiful Soup for parsing HTML trees. [The code is publicly available on Github](https://github.com/ccorcos/5cmenuparser){: .link}.

You can find this app on the [App Store](https://itunes.apple.com/us/app/5c-menu/id512440171){: .link}, but it hasn't been working lately -- apparently the dining hall websites have changed causing the parser to break. I haven't dealt with it since. If you are interested in helping on this front, feel free to contact me.

If I were to rewrite this app, I would make a web app using [Meteor's epic Cordova integration](https://github.com/meteor/meteor/wiki/Meteor-Cordova-Phonegap-integration){: .link} to port over to all mobile platforms. I would also use [Import.io](http://import.io){: .link} to extract the data because the python parser sadly took the most time of anything and now its basically worthless.

<div class="tc">
<img class="tall-img" src="/img/mudd.jpg">
<img class="tall-img" src="/img/scripps.jpg">
<img class="tall-img" src="/img/pitzer.jpg">
<img class="tall-img" src="/img/cmc.jpg">
<img class="tall-img" src="/img/pomona.jpg">
</div>
