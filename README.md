# README

## What does this app do? 
  
  * Glad you asked! Sweater Weather is an API backend client that has multiple endpoints to satisfy your need to look up weather at a certain location, find a road trip end point weather conditions and trip duration, as well as finding munchies along the way.

## Ruby version
  This app was implemented utilizing ruby V2.5.3.

## System dependencies

  * System dependencies are:
    * 'rails 6.1.1'
    * 'figaro'
    * 'faraday'
    * 'fast_jsonapi'
    * 'bcrypt', '~> 3.1.7'
    
  * Testing dependencies are:
    * 'rspec'
    * 'capybara'
    * 'simplecov'
    * 'shoulda-matchers'
    * 'webmock'
    * 'vcr'
## Configuration/Installation

  * To install this app:
    1. Clone repository
    2. run 'bundle install' in CLI
    3. run 'rails db:{create,migrate}' in CLI
    4. run 'figaro install' in CLI
      * navigate to config/application.yml and implement your API keys, you will need:
        1. WEATHER_API_KEY (provided from OpenWeather)
        2. LOCATION_API_KEY (provided from MapQuest API)
        3. IMAGE_API_KEY (provided from Bing services)
        4. BUISNESS_API_KEY (provided from Yelp - key includes 'Bearer' tag)
    5. run 'bundle exec rspec' in CLI and you should expect 55 passing tests

## Database schema
  * simple one table schema design:
  ![Screen Shot 2021-01-19 at 2 40 58 PM](https://user-images.githubusercontent.com/68167430/105096563-83d5fa00-5a64-11eb-89c8-396e0f0eb22e.png)

  
## Endpoints

## Services (job queues, cache servers, search engines, etc.)

 #### This application utilizes the following apis
  
  ##### OpenWeather
  ##### Yelp
  ##### MapQuest
  ##### Bing


