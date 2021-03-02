# Message in a Bottle

A single-use, analytics-free email subscription platform built to distribute my newsletter. [Live site lives here](http://letters.evangelinegarreau.com/).

## Why?

When I decided to start a newsletter, it was important to me to have a fully analytics-free experience with no indication of who's opening my emails or what links are being clicked on. I wanted to feel like I was tucking a carefully rolled letter into an old rinsed-out rootbeer bottle, sealing it with cork and wax, and then lobbing it out into the ocean and waving goodbye. Who knows whose shores it will wash upon? Maybe someday they'll write me back, or maybe I write the letter for no one but myself.

## How?

This is a simple Sinatra web app with a Postgres database and an artisanal HTML/CSS front end. It uses [Mailgun](https://www.mailgun.com/) to send emails (see [models/mailer](models/mailer.rb) to check out the logic). Each send is triggered from the command line via a [rake task](Rakefile), which takes in an HTML file (the email) and a subject line and sends to the subscriber list.

## What's your newsletter?

Currently it's called Good Question, a fortnightly essay based on survey responses to low-stakes, open-ended questions. [Subscribe here.](http://letters.evangelinegarreau.com/subscribe)
