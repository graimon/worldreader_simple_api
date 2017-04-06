# Worldreader Simple API

This is the source code for an excersise requested by [Worldreader](https://www.worldreader.org/).
Its purpose is to offer an API that'll show some sample books and categories.

## Instructions for installation and local running

### Prerequisites

* Ruby 2.0+ (Developed with 2.3.1)
* Postgres installed and configured correctly
* bundler gem installed

### Installation

* Install required gems
```
    $ bundle install
```

* Run migrations
```
    $ rake db:create db:migrate
    $ rake db:create db:migrate APP_ENV=test
```

* Run tests
```
    $ rspec
```

* Start local server
``` 
   $ puma config.ru
```

## Usage

### Routes

```
             Index of Books   v1     GET                            /api/v1/books.json
               Shows a Book   v1     GET                      /api/v1/books/:uuid.json
        Index of Categories   v1     GET                       /api/v1/categories.json
           Shows a Category   v1     GET                   /api/v1/categories/:id.json
Shows all Books in Category   v1     GET             /api/v1/categories/:id/books.json
```

### Pagination Parameters

All list actions (/books, /categories and /categories/:id/books) accepts optional pagination parameters page and per_page. The default page size is 20.

For example: 
```
/api/v1/books.json?page=10&per_page=50
/api/v1/categories.json?per_page=50
/api/v1/categories/106/books.json?page=4
```

### Response examples

All list actions responses are JSON documents containing the list of items and pagination metadata.

For example, the response to /api/v1/books.json?page=99&per_page=1 would be:

```json
{
  "per_page": 1,
  "page": 99,
  "total_pages": 29346,
  "total_results": 29346,
  "books": 
  [
    {
      "uuid": "f41a56ce-e705-4c63-ad47-a3a7d376077e",
      "id": 67659,
      "title": "Die beursie (Teacher's Manual)",
      "author": "Paula Raubenheimer, Dr. Hannie Menkveld",
      "language": "afr",
      "createtime": "2015-06-15T11:44:04.600+02:00"
    }
  ]
}
```

## Comments on the chosen solution

As it is a simple excersise, I've decided to build it in Ruby (my speciality), using some simple and powerfull gems that allow to delegate the hard work and put focus on the specific solution.

It has been developed basically using [grape](https://github.com/ruby-grape/grape) framework for routing and controllers and [Sequel](http://sequel.jeremyevans.net/) for Database access.

I could have chosen Rails to do this, but I have decided for this lighter solution (around 40Mb of consumed memory).

### Decisions taken

I've decided to use de uuid of a Book as its identifier, instead of the id as it was initially required. The reason is for database performance, I had no control on the given database and the only index in the books table was the primary key for uuid field. If I had used the id, the response time would have increased drastically.
I've decided not to sort the books result, for the same reason as before, I can't add more indexes, and sorting over unindexed fields on a large table is not recommended.
On the other side, I've decided to sort categories by its listorder, although there was not an index neither. In this case, the cardinality of the categories table (less than 200 records) is so small that any database can handle it.

### Design

I've basically applied the MVC pattern, as it suits perfectly with REST APIs, inheriting from Grape::Api for controllers, and using POROs for Models and Serializers. To query the database, I've used Sequel methods, very intuitive and descriptive.

### Test coverage

I've decided not to cover all the classes with tests, only models have been fully tested.

The rest, controllers and serializers are covered by integration tests. My belief is that, in a simple applications like this one, there is no value in over testing simple classes as serializers, because there is not much logic on them and are already being tested in integration tests.

