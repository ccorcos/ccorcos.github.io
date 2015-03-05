---
layout: post
title: Meteor and React
---

After learning about [React Native](http://jlongster.com/First-Impressions-using-React-Native){: .link} and all the hype about [React](http://facebook.github.io/react/){: .link}, I decided to give it a serious try. I read the entire documentation (which was actually quite short) and I was suprised about its elegance. My favorite part about it is that you can create your entire UI in Javascript -- no markup!

It was very easily to integrate React with Meteor (I love Meteor). I created some syntax jazz that allowed me be very expressive in the DOM layout in Coffeescript, without having to use JSX. Check it out:

      (Header  [
        (Title 'Signup')
      ])
      (Content {header: true}, [
        (form {onSubmit: @submitForm}, [
          (List {}, [
            (Item {input: true}, [
              (input {type:'text', placeholder:'username'})
            ])
            (Item {input: true}, [
              (input {type:'password', placeholder:'password'})
            ])
            (Item {input: true}, [
              (input {type:'password', placeholder:'verify'})
            ])
          ])
          do => if @state.error then (Error @state.error)
          (Padding [
            (Button {type:'block', color:'balanced'}, 'signup')
          ])
        ])
      ])

To do this, I did two things. Every component your create returns a function that wraps the `createElement` function so you can use them directly without having to call `createElement` every time. Also, the first argument (the props) is optional, and the second argument is either one elemnt, or an array of elements. Thus we don't need a bunch of awkward commas.

Next, I created some mixins that allow you to define subscriptions within the component and reactively update the state of the component using Meteor's built in reactivity.


    getMeteorState:
      players:        -> Meteor.users.find({}, { sort: { 'profile.score': -1, username: 1 } }).fetch()
      selectedPlayer: -> Meteor.users.findOne(Session.get('selectedPlayerId'))

    subscribe: ->
      Reactor.subscribe('players')

Lastly, I created a new namespace and a [package called Reactor](https://github.com/ccorcos/meteor-reactor){: .link} that wraps around Iron Router to render the correct React component for different routes.

In conclusion, I'm really impressed with React. I absolutely love how I can use all abstraction powers I could possibly want. No longer do I feel like I'm fighting the framework or markup language. I really hope Meteor seriously considers React instead of Blaze.