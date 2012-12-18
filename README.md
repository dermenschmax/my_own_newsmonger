my_own_newsmonger
=================

This is a simple re-implementation of newsmonger. Newsmonger is a kind of mongodb
tutorial. Sadly it didn't work for me. That's why this project was born.


My setup
-------------

* Rails 3.2.8
* ruby 1.9.3p194
* mongo_mapper-0.12.0


What should happen
------------------

To get a clue about the example first read the original
tutorial: http://www.mongodb.org/display/DOCS/MongoDB+Data+Modeling+and+Rails


What's really in here
---------------------

I modeled a very simple story model. It has a title, the text and an username. As
an addon there are embedded comments. They are linear so far. You cannot comment
on another comment. The interface is not fully working but you get the important
parts.

The example shows how to create and operate with mongo objects. As long as it is
simple. 