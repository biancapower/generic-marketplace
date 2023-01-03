# Generic Marketplace

This app has been deployed on Fly.io at [https://generic-marketplace.fly.dev](https://generic-marketplace.fly.dev).

## Overview

This is a generic marketplace app that allows users to create listings, view listings, and purchase listings. It is built with Ruby on Rails.

## User Flow

![User Flow](./docs/generic-marketplace-overview.gif)

## Running Locally

The following are requirements in order to run this app locally:
- Ruby version 2.7.5
- Node version 16.16.0
- Rails version 6.1.6
- PostgreSQL

Once the above have been installed / set up:
1. clone this repo to your machine
1. `cd` into the application folder
1. `bundle install`
1. `yarn install`
1. `rails db:create`
1. `rails db:migrate`
1. `rails s` to start the rails server
