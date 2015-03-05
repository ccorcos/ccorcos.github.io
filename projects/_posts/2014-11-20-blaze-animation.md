---
layout: post
title: Animation with Meteor
---

I was messing around the other day trying to figure out how to get Blaze to do animation. I discovered an undocumented function `_uihooks` that gives you control over how elements are inserted, moved, and removed from the DOM. 

I created a [repo and started playing around](https://github.com/ccorcos/meteor-blaze-animations){: .link}. My big insight from this is that we can use [VelocityJS UI Pack animations](http://julian.com/research/velocity/#uiPack) to call animations via a block helper.

This lead to two packages that I find immensely useful.

First, there is the bare-bones [ccorcos:animate](https://github.com/ccorcos/meteor-animate){: .link} package that allows you to wrap an element with a block helper that specifies the UI Pack animation.

    {% raw %}
    {{#animate in='transitions.fadeIn' out='transitions.fadeOut'}}
      ...
    {{/animate}}
    {% endraw %}

And you can create your own animations using `$.Velocity.RegisterEffect`!

A more popular package [ccorcos:transitioner](https://github.com/ccorcos/meteor-transitioner){: .link} integrates with Iron Router to specify transitions between routes! It basically the same package with an autorun to specify the transitions around your `{% raw %}{{>yeild}}{% endraw %}` template.