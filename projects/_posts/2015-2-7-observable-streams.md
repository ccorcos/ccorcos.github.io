---
layout: post
title: Observable Streams
---

Observable streams are one of the coolest programming patterns I've read about in a long time. If you don't know about them, check out [this awesome talk](https://www.youtube.com/watch?v=XRYN2xt11Ek){: .link} and this [awesome interactive tutorial](http://jhusain.github.io/learnrx/){: .link}.

Being a huge meteor fan, I've come to love [Tracker](https://www.meteor.com/tracker). It is the heart and soul of any meteor app and its only [500 lines of code](https://github.com/meteor/meteor/blob/devel/packages/tracker/tracker.js){: .link}! It is incredibly elegant and I recommend you [learn how it works](http://manual.meteor.com/#deps){: .link}.

The reason I want to bring up Tracker is because that's how we integrate reactivity into Meteor. Observable streams are another way of integrating reactivity into your app. I want to show you a perfect example of why observable streams can be very useful.

Observable streams are perfect for UI events. Once upon a time, I [wrote this horrible mess](https://github.com/ccorcos/meteor-swipe) to create a swipable UI. Writing this component with a slew of state variables turned into a giant headache of listening to events and changing state variables appropriately. However, using observable streams, we can handle UI events more concicely and understandably.

I created a [meteor package for observable streams that uses Tracker](https://github.com/ccorcos/meteor-tracker-streams){: .link}. I could have use [Bacon.js](https://baconjs.github.io/){: .link}, [RxJS](https://github.com/Reactive-Extensions/RxJS){: .link}, or [Highland.js](http://highlandjs.org/){: .link} but I chose to implement observable streams with Tracker for two reasons:

1. I wanted to get a better understanding of how streams work.

2. I wanted observable streams seamlessly integrate into Meteor.

Using Tracker, we can define observable streams within our Template helpers and they'll reactively update!

So whats the big hype? Check out this [swipe menu I made](http://tracker-streams-menu.meteor.com/){: .link} and notice how smooth the physics are, it works on desktop or mobile, and it has no jank. This slide menu was created in only 50 lines of code. Here's how:

Everything is defined within the `menu.rendered` function:

    Template.menu.rendered = ->
      self = this


We create some streams, purify, and merge them to keep track of the start, movement, and end of the menu UI events.

      # start stream of x position values
      toushStart = @eventStream("touchstart", ".handle")
        .map (e) -> e.originalEvent.touches[0].pageX
      mouseDown = @eventStream("mousedown", ".handle")
        .map (e) -> e.pageX
      startStream = Tracker.mergeStreams(toushStart, mouseDown)

      # cancel on a variety of annoying events
      touchEnd = self.eventStream("touchend", ".page", true)
      touchCancel = self.eventStream("touchcancel", ".page", true)
      touchLeave = self.eventStream("touchleave", ".page", true)
      mouseUp   = self.eventStream("mouseup", ".page", true)
      mouseOut  = self.eventStream("mouseout", ".page", true)
      mouseOffPage = mouseOut
        .filter (e) -> (e.relatedTarget or e.toElement) is undefined
      endStream = Tracker.mergeStreams(mouseUp, mouseOffPage, touchEnd, touchCancel, touchLeave)

      # create a move stream on demand returning the x position values
      mouseMove = self.eventStream("mousemove", ".page", true)
        .map (e) -> e.pageX
      touchMove = self.eventStream("touchmove", ".page", true)
        .map (e) -> e.originalEvent.touches[0].pageX
      moveStream = Tracker.mergeStreams(mouseMove, touchMove)

We also keep track of when the menu is animating so we don't interrupt any animations with a new animation.

      # create an animation stream to block the start stream from interrupting an animation
      animatingStream = @stream(false)

And here somes the meat of our component. We map over every startSteam unless we are currently animating. We record the initial position of the menu handle and the offset within the handle that we touched. We also keep track of the velocity of the touch so we can flick it.

      # get the jquery object we're going to drag
      $menu = $(@find('.menu'))

      startStream
        .unless(animatingStream)
        .map (x) ->

          initLeft = $menu.position().left
          offset = initLeft - x
          lastLeft = initLeft
          velocity = 0

If we touch the menu without moving, we must assume its a toggle. We use the amazing [VelocityJS](http://julian.com/research/velocity/){: .link} library for creating the animation classes.

          # toggle menu position
          toggle = ->
            if lastLeft > -menuWidth/2
              # close it
              $menu.velocity({translateX: [-menuWidth, 0], translateZ: [0, 0]}, {duration: 400, easing: 'ease-in-out', complete: -> animatingStream.set(false)})
            else
              # open it
              $menu.velocity({translateX: [0, -menuWidth], translateZ: [0, 0]}, {duration: 400, easing: 'ease-in-out', complete: -> animatingStream.set(false)})

When the swiping ends, we call this resolve function. This takes care of calling toggle if necessary and otherwise calculated the position of the menu using momentum and animates the menu closed based on the speed of the flick!

          # resolve menu position
          resolve = ->
            animatingStream.set(true)
            # wait for animation to finish
            if initLeft is lastLeft and velocity is 0
              toggle()
              return

            momentum = velocity*3
            if lastLeft + momentum > -menuWidth/2
              momentum = Math.abs(momentum)
              duration = Math.min(-lastLeft/momentum*100, 400)
              $menu.velocity({translateX: 0, translateZ: 0}, {duration: duration, easing: 'ease-out', complete: -> animatingStream.set(false)})
            else
              momentum = Math.abs(momentum)
              duration = Math.min((200-lastLeft)/momentum*100, 400)
              $menu.velocity({translateX: -menuWidth, translateZ: 0}, {duration: duration, easing: 'ease-out', complete: -> animatingStream.set(false)})

The utilize the previous two functions here. On every startStream event, we listen to the moveStream until the endStream first in which we call the resolve function. For each move, we simply update the position of the element, and update the variables for the position and the velocity.           

          moveStream
            .takeUntil(endStream, resolve)
            .forEach (x) ->
              # wait for animation to finish
              left = strangle(x + offset, [-menuWidth, 0])
              velocity = left - lastLeft
              lastLeft = left
              $menu.velocity({translateX: left, translateZ: 0}, {duration: 0})


Anyways, that's it. Pretty slick right?! My mind was blown once I realized how useful observable streams are for abstracting the state of UI events. [Here's the code for the menu](https://github.com/ccorcos/meteor-tracker-streams/tree/master/examples/slide-menu){: .link} and [let me know what you think](mailto:ccorcos@gmail.com){: .link}!



