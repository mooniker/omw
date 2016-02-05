# OMW (on my way!)

Put [TransitScreen](http://transitscreen.com/)-style bus stop arrival/departure dashboards in a tab on your web browser.

This is a practice project made with Ruby on Rails with PostgreSQL, jQuery/Javascript, Mapbox, and many calls to the [WMATA API](https://developer.wmata.com/).

##

## Installation

You're going to need to have a [PostgreSQL server installed](https://wiki.postgresql.org/wiki/Detailed_installation_guides) and running. Here's the rundown on command-line-fu needed to get this app up and running:

```bash
git clone https://github.com/mooniker/omw.git
cd omw
bundle install
rake db:create db:migrate db:seed
rails s
```
