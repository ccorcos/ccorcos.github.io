---
layout: post
title: Raw Guitar Tuner
---

Using the code from my [last post](/projects/2014/12/20/webaudio-waterfall.html){: .link} I created what I like to call a "raw" guitar tuner. This tuner is just a zoomed in waterfall plot of the frequency spectrum of a guitar in standard tuner. The white lines are guides for the E-A-D-G-B-E frequencies. Now you can tune your guitar based on the raw frequency information!

Here you can see me tuning the A on my guitar.

![](https://raw.githubusercontent.com/ccorcos/webaudio-guitar-tuner/master/public/screenshot.png)

One thing I like about this kind of tuner is that you have finer-grained tuning in some sense. While the sample rate isn't phenomenal, you get harmonic information to tune from. In the image above, you can see the A frequency on the left, but you can also see the first harmonic (the octive) and the second harmonic (the high-E). You might notice that the high-E harmonic isn't perfect. That because, mathematically, [we can't have perfect fifths](http://blogs.scientificamerican.com/roots-of-unity/2014/11/30/the-saddest-thing-i-know-about-the-integers/){: .link}! Mind-blowing, if you ask me.

[Play with code](https://github.com/ccorcos/webaudio-guitar-tuner){: .link}, check out the [demo](http://webaudio-guitar-tuner.meteor.com/){: .link} and [let me know what you think](mailto:ccorcos@gmail.com){: .link}!
