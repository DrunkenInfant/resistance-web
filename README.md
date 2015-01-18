Resistance Web
==============

This web service may be used to aid in playing the board game Resistance or
Avalon.
Currently it only supports the basic rules without any extra roles like Merlin.
It is not currently fit to be used for playing remotely, is it strongly
recommended to sit in the same room when playing.

Features
--------

* Easily create a new game by only selecting who to play with.
* Nominate, vote and choose mission result. The game keeps track of everything
  and only lets you take legal actions.
* No information leakage provided no player is sharing a device or can see
  other players screens.
* Interface suitable for using a smart phone or tablet.
* Automatically update progress as other players take action using websocket.

### Missing features

* Error reporting if user does do something illegal.
* View history, for example previous votes.
* Comments or notes.
* In game chat.

### Comming features
* An icon and image pack with permissive licensing.
* Rename players instead of using the default Player 1-10.
* Include roles such as merlin.
* In game chat.

Installation
------------

Install ruby and bundle. Consult your favourite search engnie for that. rvm is
recommended.

1. Run `bundle install`.
2. Run `./build_production.sh`
3. Run `SECRET_KEY_BASE=$(cat .secret_token_file) DEVISE_SECRET=$(cat .devise_secret_file) RAILS_ENV=production rails s` to start server

Notes on the implementation
---------------------------

* The service is backed by a sqlite3 database.
* The service is implemented using Ruby on Rails 4.
* It consists of a backend JSON API and a javascript frontend implemented with
  Ember.
