# Worldreader Simple API


## Instructions for installation and local running

### Prerequisites

* Ruby 2.0>
* Postgres installed and configured correctly
* bundler gem installed

### Installation

* Install required gems
    $ bundle install

* Run migrations
    $ rake db:create db:migrate
    $ rake db:migrate APP_ENV=test

* Run tests
    $ rspec

* Start server
    $ puma config.ru