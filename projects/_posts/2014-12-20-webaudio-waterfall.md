---
layout: post
title: Web Audio API Waterfall
---

Waterfall plots are my favorite intersection engineering, math, algorithms, machine learning,  music, and art. The FFT was a ground breaking algorthm that runs in `O(n*log(n))`. Interestingly, this is the fastest way to do a convolution as well. Using the FFT, we can take a time-signal and get the frequency spectrum of that signal. This is used everywhere in engineering, from stuctural analysis from earthquakes to filtering sensor signals. The underlying math is amazing as well. It is the first time I understood the usefulness of imaginary numbers!  In machine learning, this is the first step to audio analysis to determine spoken words from an audio signal. Whenever you speak to Siri, this algorithm is running. In music, the FFT is used for filtering and visualizing sound. And as far as art, you can make cool visualizations of sound. For example, here's a screenshot from listing to [GRiZ - The Future Is Now](https://www.youtube.com/watch?v=tPqLfsmL0bM){: .link}.

![](https://raw.githubusercontent.com/ccorcos/webaudio-waterfall/master/public/screenshot.png)

Anyways, [play with code](https://github.com/ccorcos/webaudio-waterfall){: .link}, check out the [demo](http://webaudio-waterfall.meteor.com/){: .link} and [let me know what you think](mailto:ccorcos@gmail.com){: .link}!
