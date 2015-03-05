---
layout: post
title: Room Tuner
---

With my signals background, I've always been interested in the concept of room tuning. Have you ever been in a loud bar with terrible sound quality? Maybe the sound echos off of every wall before you hear it. Maybe the trebble is way to loud and its ripping your ear drums? 

Imagine setting up the sound system for a giant concert. There are a variety of speakers in various places. How so can you make sure all the speakers sound good together? The answer is [equalization](http://hyperphysics.phy-astr.gsu.edu/hbase/audio/equal.html){: .link}. Of course you can sit there an listen to the speakers, adjusting the sound as you please, but there is an engineering approach. If you play a known signal through the speakers, you can set up a microphone hooked up to a spectrum analyser and make sure you are hearing the appropriate spectrum.

With the new [Web Audio API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API){: .link} avaiable on Firefox and Chrome, we can create a spectrum analyzer in our web browser. After reading and experimenting for a couple hours, I was able to get a simple spectrum analyzer up and running. [Here's the code](https://github.com/ccorcos/room-tuner){: .link} and [demo](http://room-tuner.meteor.com){: .link}! This app plays [pink noise](http://hyperphysics.phy-astr.gsu.edu/hbase/audio/equal.html){: .link} and the microphone listens to the response and plots the spectrum

![](https://raw.githubusercontent.com/ccorcos/room-tuner/master/public/screenshot.png)

Now, this setup has all sorts if problems.

1. There is no internal Mac equalizer. However, you can use [Soundflower](https://github.com/RogueAmoeba/Soundflower){: .link} or a hardware equalizer if you have one.

2. The microphone on your Mac is probably terrible. Not to mention the location of the microphone is right next to a big reflective screen. So you'll probably want to use an external microphone. 

These problems aren't unsurmountable though. [Let me know how it works for you](mailto:ccorcos@gmail.com){: .link}!