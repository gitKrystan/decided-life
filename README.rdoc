# Decidedly

##### By Krystan Menne

Decidedly is an app that helps users make decisions using a [decision matrix](https://en.wikipedia.org/wiki/Decision_matrix).
Users create a matrix then options and decision criteria. The user weights the decision criteria based on their priorities, then assigns scores to each option based on these criteria.
The matrix weights each score based on the criteria, then outputs a total weighted score for each option.

## Prerequisites
* Ruby 2.2.2 or greater

* Rails 4.2.6 or greater

* PostgreSQL

## Installation
1. `$ git clone https://github.com/gitKrystan/decidedly`
1. Change into the new directory
1. `$ bundle install`
1. Create database and run migrations
  1. `$ rake db:create`
  1. `$ rake db:migrate`
  1. `$ rake db:test:prepare`
1. Run the tests (see below)

## Running / Development
1. `$ rails serve`
1. Visit your app at [http://localhost:3000](http://localhost:3000).

## Running Tests
`$ rspec`

## License
Copyright (c) 2016 Krystan Menne
This software is licensed under the MIT license.
