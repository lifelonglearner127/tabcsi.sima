# TABC: CR (Compliance Reporting)

## Former Names

* Retail Compliance Reporting (RCR)
* Self Inspection (SI)
* Audit

## Dependencies

### General

* Ruby 2.5.1
* Node 8 (LTS)
* Yarn

### Development

* [Overmind](https://github.com/DarthSim/overmind)

## Deploying

    > bin/deploy sandbox
    > bin/deploy production

## Development

### Getting Set Up

    > bundle install
    > yarn install
    > bin/rails db:setup
    > bin/rails admin:load_settings
    > bin/rails admin:data_feed
    > bin/rails admin:build_forms
    > cp .env.example .env

Edit `.env` file as necessary.

### Developing

    > yarn start

This will start the Rails and Webpack servers through Overmind.
