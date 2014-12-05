---
layout: research
title: Research
permalink: /research/
---

<!-- probably want to do all this in html -->

# Research

My research focus is at the intersection of robotics and machine learning. On the machine learning side of things, I'm very interested in temporal models and unsupervised learning. On the robotics side of things, I'm really interested in graphical models for localization and planning.

## Smoothing and Mapping

Smoothing and mapping (SAM) is a graph optimization technique for simultaneous localization and mapping (SLAM). It outperforms the typical Kalmann filtering techniques by recovering a globally optimal solution at the price of computation. For a project in my Coordinated Mobile Robotics class, I wrote a generalized SAM implementation and showed in simulation how it could be used for heterogeneous robot teams with heterogeneous sensors. The beauty of SAM is its simplicity. In the end, everything boils down to a least-squares optimization which translates to a sparse matrix inversion in the robotics mapping context.

[Check out the code and the writeup on Github](https://github.com/ccorcos/robotics-smoothing-and-mapping){: .link}.

## Interactive Object Recognition

Karol Hausman and I created dynamic bayesian network modeling the actions and observations of a robot manipulating an object. We formulated a minimum entropy optimization for determining the optimal action for better object recognition. We published a workshop paper in IROS 2014 on this work. [The code for this project is all open source on Github as well](https://github.com/ccorcos/towards-interactive-object-recognition){: .link}.

My recent focus has been learning an unsupervised version of this model with perfect perception. I've been experimenting with recurrent neural networks (RNNs) and exploring models that leverage denoising autoencoders. [This work is ongoing and also open source on Github](https://github.com/ccorcos/interactive-object-recognition){: .link}.

## Favorite Papers

- [Reducing Dimensionality with Neural Networks](http://www.cs.toronto.edu/~hinton/science.pdf){: .link}
- [Building High-level Features Using Large Scale Unsupervised Learning](http://static.googleusercontent.com/media/research.google.com/en/us/archive/unsupervised_icml2012.pdf){: .link}
- [Square Root Smoothing and Mapping](http://www.cc.gatech.edu/~dellaert/ftp/Dellaert06ijrr.pdf){: .link}
