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
  ### get api/v1/forecast
   * acceptable parameters are 'location' (string - i.e. Denver,CO) and units (string - 'imperial' or 'metric')
    * this end point allows the requestor to find weather information for a specified location, sample output of this endpoint:
```
{
  "data": {
      "id": null,
      "type": "forecast",
      "attributes": {
          "temp": 3.61,
          "day_feels_like": 0.0,
          "description": "broken clouds",
          "date": "2021-01-19 14:43:10 -0700",
          "clouds": 72,
          "sunset": "2021-01-19 17:04:03 -0700",
          "sunrise": "2021-01-19 07:17:07 -0700",
          "humidity": 27,
          "uvi": 0.59,
          "visability": 10000,
          "icon": "04d",
          "hourly_weather": [
              {
                  "time": "14:00:00",
                  "temp": 3.61,
                  "wind_speed": 2.32,
                  "wind_direction": "SSE",
                  "description": "broken clouds",
                  "icon": "04d"
              }, ...
          ],
          "daily_weather": [
              {
                  "date": "2021-01-19",
                  "max_temp": 3.61,
                  "min_temp": -2.1,
                  "description": "overcast clouds",
                  "sunset": "2021-01-19 17:04:03 -0700",
                  "sunrise": "2021-01-19 07:17:07 -0700",
                  "icon": "04d"
              }, ...
           ]
        }
    }
}

```
 ### get api/v1/backgrounds
   * acceptable parameters are 'location' (string - i.e. Denver,CO)
    * this end point allows the requestor to find a picture for a specified location, sample output of this endpoint:
```
{
    "data": {
        "id": null,
        "type": "background",
        "attributes": {
            "bing_logo": "https://static.wikia.nocookie.net/logopedia/images/e/ee/Bing_2016.svg/revision/latest/scale-to-width-down/1000?cb=20160115161107",
            "microsoft_privacy_agreement": "https://go.microsoft.com/fwlink/?LinkId=521839",
            "image": "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Denver_skyline.jpg/1200px-Denver_skyline.jpg",
            "width": 1200,
            "height": 794,
            "host_page": "https://en.wikipedia.org/wiki/Denver",
            "host_page_display": "https://en.wikipedia.org/wiki/Denver",
            "date_published": "2020-05-09T05:48:00.0000000Z"
        }
    }
}
```

 ### post api/v1/users
  * parameters must be sent as a json payload, acceptable parameters are email, password, password_confirmation (all strings)
    * this end point allows the requestor generate a new user in the internal data base and build and associated api_key, sample response below:

![Screen Shot 2021-01-19 at 3 33 18 PM](https://user-images.githubusercontent.com/68167430/105101181-b46d6200-5a6b-11eb-9f23-218b846aad27.png)


### post api/v1/sessions
  * parameters must be sent as a json payload, acceptable parameters are email, password (all strings)
    * this end point allows the requestor verify a user by their email and password - returns email and api_keys, sample response below:
    
![Screen Shot 2021-01-19 at 3 39 37 PM](https://user-images.githubusercontent.com/68167430/105102787-994f2200-5a6c-11eb-9365-587a7832cf18.png)

### post api/v1/road_trip
  * parameters must be sent as a json payload, acceptable parameters are 'origin' and 'destination' (string - i.e. Denver,CO), api_key (string provided from user data) and units (string - 'imperial' or 'metric')
    * this endpoint allows the requestor to build a roadtrip that will return trip details, sample response below:
   
![Screen Shot 2021-01-19 at 3 45 15 PM](https://user-images.githubusercontent.com/68167430/105103230-796c2e00-5a6d-11eb-8282-412c8360a301.png)

### get api/v1/munchies
  * acceptable parameters are 'origin' and 'destination' (string - i.e. Denver,CO), food (string - type of restaurant i.e. chinese) and units (string - 'imperial' or 'metric')
    * this endpoint allows the requestor to fetch trip details similar to roadtrip but will include a restaurant of your food choice at the destination, sample response below:
   
![Screen Shot 2021-01-19 at 3 49 45 PM](https://user-images.githubusercontent.com/68167430/105103537-fdbeb100-5a6d-11eb-8296-c6ddd85cc836.png)

## Services/APIs

 #### This application utilizes the following APIs
  
 * OpenWeather
 * Yelp
 * MapQuest
 * Bing


