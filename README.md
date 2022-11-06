# SLOT BOOKING APP

![Coverage Badge](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/pkivana/6cfb4fc7d7e50f7158c03890c1a4a513/raw/slot-booking-app__heads_main.json)

This APP is implemented so companies can book a time slot to load or unload goods at a warehouse

## Requirements

Here's the list of requirements to run APP in your dev environment.

### Homebrew

The following setup instructions use [Homebrew](https://brew.sh/) for all installation commands, so be sure to install it first before moving on.

### NodeJS 18.x

Install a Node version manager (like `nvm`). Then install Node JS version 18.x .

### Yarn 1.22.x

```shell
brew install yarn
```

### Ruby 2.7.6

Install a Ruby version manager. People usually choose between [rbenv](https://github.com/rbenv/rbenv) and [rvm](https://rvm.io/rvm/install). Then install Ruby v2.7.6.

### Get the code

Extract git repo

```shell
git clone git@github.com:pkivana/slot-booking-app.git
cd slot-booking-app
```

```shell
# start using related database.yml file
cp config/database.yml.example config/database.yml
```

Then:

- Run `bundle install` to install all needed gems
- Run `yarn install` to install all needed packages
- Run `rails webpacker:compile` to compile assets

### Databases Setup

```shell
# Initial setup
bundle exec rake db:create

# Running migrations
bundle exec rake db:migrate

# Insert seed data
bundle exec rails db:seed
```

### Running Tests

RSpec is used

```shell
bundle exec rspec spec
```
