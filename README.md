# Sweater Weather

<img src="https://media.giphy.com/media/l0HlPwMAzh13pcZ20/giphy.gif" alt="weather" align="center">

This is the final Mod 3 project as part of Turing School of Software and Design's Back-End Engineering program.  This is a Rails API built to accompany a hypothetical Front-End application consuming the Back-End's endpoints for gathering weather forecast data (current, 8-hour, and 5-day) for a location, a background image of the city, registering users, creating sessions, and creating road trips.  The road trip functionality goes further to grab travel time between two entered locations and the weather forecast for that estimated time of arrival.

As always, Test-Driven Development was a major concept practiced in the making of this project.

## Table of Contents

  - [Introduction](#introduction)
  - [Functional Overview](#functional-overview)
  - [Setup](#setup)
  - [Runing the tests](#running-the-tests)
  - [Deployment](#deployment)
  - [Authors](#authors)

## Introduction
  * [Project Overview](https://backend.turing.io/module3/projects/sweater_weather/)
  * [Project Requirements](https://backend.turing.io/module3/projects/sweater_weather/requirements)

## Learning Goals
  * Expose API using Test-Driven Development
  * Expose API requiring authentication token
  * Consume multiple APIs and expose those results through endpoints
  * Format JSON using a serializer gem (I used [jsonapi-serializer](https://github.com/jsonapi-serializer/jsonapi-serializer))

## Functional Overview

This scratch Rails API consumes the [MapQuest Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/), the [OpenWeather One Call API](https://openweathermap.org/api/one-call-api) and the [Bing Search API](https://docs.microsoft.com/en-us/azure/cognitive-services/bing-web-search/).  Utilizing various endpoints from these APIs and manipulating the data through services, facades and poros, my application's backend routes could be called to return JSON-serialized data based on what the 'front end user' would input.  Search endpoints include current, hourly and daily forecasts for a location and location photos utilizing the Bing Search API.  Frontend users can also register an email and password to receive a randomly-generated API key (all saved in User table) as well as create a Session by providing this API key.  Road trips can also be created by providing the API key, an origin location and a destination location.  This provides the frontend with the entered locations, drive time, and the forecast of the destination location at the estimated arrival time.
### Database Structure

<img src='https://i.postimg.cc/xdfXRHk6/Screen-Shot-2021-01-19-at-10-26-40-PM.png'>


## Setup

### Prerequisites

These setup instructions are for Mac OS.

This project requires the use of `Ruby 2.5.3` and `Rails 5.2.4.3`.
I also use `PostgreSQL` as my database.

### Local Setup

To setup locally, follow these instructions:
  * __Fork & Clone Repo__
    * Fork this repo to your own GitHub account.
    * Create a new directory locally or `cd` into whichever directory you wish to clone down to.
    * Enter `git clone git@github.com:<<YOUR GITHUB USERNAME>>/sweater_weather.git`
  * __Install Gems__
    * Run `bundle install` to install all gems in the Gemfile
    * Run `figaro install` to create the hidden `application.yml` file
  * __Set Up Local Database and Migrations__
    * Run `rails db:{drop,create,migrate}`
  * __Add API Keys as ENV Variables__
    * Sign up for API keys for all three APIs: [Bing](https://docs.microsoft.com/en-us/azure/cognitive-services/bing-web-search/) (requires Azure signup), [OpenWeather](https://openweathermap.org/api/one-call-api), and [MapQuest](https://developer.mapquest.com/documentation/geocoding-api/)
    * Enter these keys in the `application.yml` file created above as follows:
    ```
    MAPQUEST_KEY: <YOUR KEY>
    OPENWEATHER_KEY: <YOUR KEY>
    BING_KEY: <YOUR KEY>
    ```


## Running the tests

  * `cd` into the folder you cloned this repo into and run `rails server`.
  * Run `bundle exec rspec`, and you should see all passing tests.

## Playing with Endpoints
In an API tool such as Postman, you can experiment with hitting information using the endpoints in this project.
To do so:
  * `cd` into whichever folder houses this cloned project.
  * Run `rails server` from the command line.
  * Enter `http://localhost:3000` as the domain, followed by whichever endpoint you are trying to hit.  See [this page](https://backend.turing.io/module3/projects/sweater_weather/requirements) for more information.
