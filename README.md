[![Build Status](https://travis-ci.org/chrisccerami/scene-hub-v2.svg?branch=infinite-scroll)](https://travis-ci.org/chrisccerami/scene-hub-v2)[![Coverage Status](https://coveralls.io/repos/pezcore343/scene-hub-v2/badge.png)](https://coveralls.io/r/pezcore343/scene-hub-v2)

# Scene Hub

## A Ruby on Rails app for tracking local music

The most current deployed version of the app can be found [here](https://www.scene-hub.herokuapp.com)

Scene Hub is designed as a platform for fans to connect to the musicians in their communitiy. Bands can share tour dates and locations, photos, and news with people who are looking to support local music.

Front page banner
![Scene Hub banner](http://i.imgur.com/mMENDlm.png)

Users can views all upcoming shows on the home page, and can search for concerts by zip code and genre.

Band profiles
![Scene Hub band profiles](http://i.imgur.com/KFgAx9M.png)

Each band or musician has their own profile page where they can share photos, music, and news.

Tour history maps
![Scene Hub band maps](http://i.imgur.com/fAyTMcW.png)

Each band's profile also features a map showing where they have toured in the past. The more a musician performs at a particular venue, the larger the map marker becomes. This can give fans an at-a-glance idea of where their favortie bands play the most often. These map markers are generated automatically based on geocoded location data from each concert's venue.


Third Party Tools

Locations are geocoded using Geokit and Geokit-rails. The maps are generated by Mapbox. Paperclip was used along with Amazon's AWS S3 service for file uploads. Infinite scrolling was implemented using a combination of the kaminari gem and AJAX. Devise was used for user authentication. Foundation was used to aid in styling and CSS.
