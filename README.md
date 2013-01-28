miri
====

Miri is a Raspberry Pi-based personal assistant, controlled by voice, that specialises in answering music-related questions.

Think Siri + Music (Miri).

See it in action here: http://goo.gl/jBoJj

## Requirements

You will need:

* A Raspberry Pi (running the "soft-float" debian, available from "http://www.raspberrypi.org/downloads")
* USB mic (I used a webcam)

## Installation

Install a bunch of stuff:

    sudo apt-get install git ncmpcpp mopidy ruby ffmpeg ruby-dev mplayer sox libcurl4-openssl-dev libcurl4-gnutls-dev

and then install Mopidy:

    http://docs.mopidy.com/en/latest/installation/raspberrypi/#how-to-for-debian-7-wheezy

checkout the project:

    git clone git@github.com:AaronRandall/miri.git

and modify:

    miri/lib/miri/app_config.rb

to include API keys for each service.  You can sign-up to get API keys from:

* http://www.songkick.com/api_key_requests/new
* https://developer.wolframalpha.com/portal/apisignup.html
* https://developer.echonest.com/account/register

## Usage

Run:

    bin/miri

Say something! e.g.

* "Tell me about The Rolling Stones"
* "Play The Knife"
* "What is my next concert?"
* "When did The Beatles break up?"
* "What frequencies can a violin sound?"

## Other stuff

Run:

    bin/miri_with_detection

to allow for detecting audio (e.g. "Hello Miri!"), and automatically start Miri (hands-free, instead of having to manually run bin/miri).
