require './app/modules/weather_common'

class WeatherLocation

  include WeatherCommon

  attr_reader :temp,
              :day_feels_like,
              :description,
              :date,
              :clouds,
              :sunset,
              :sunrise,
              :humidity,
              :uvi,
              :visability,
              :description,
              :icon,
              :hourly_weather,
              :daily_weather,
              :id

  def initialize(day_weather, units = 'metric')
    @temp = requested_temp(units, day_weather[:current][:temp])
    @day_feels_like = requested_temp(units, day_weather[:current][:feels_like])
    @description = day_weather[:current][:weather][0][:description]
    @date = convert_time(day_weather[:current][:dt], day_weather[:timezone])
    @sunrise = convert_time(day_weather[:current][:sunrise], day_weather[:timezone])
    @sunset = convert_time(day_weather[:current][:sunset], day_weather[:timezone])
    @clouds = day_weather[:current][:clouds]
    @uvi = day_weather[:current][:uvi]
    @visability = day_weather[:current][:visibility]
    @icon= day_weather[:current][:weather][0][:icon]
    @humidity = day_weather[:current][:humidity]
    @hourly_weather = build_hourly_weather(day_weather, units)
    @daily_weather = build_daily_weather(day_weather, units)
  end

  private

  def build_hourly_weather(weather_data, units)
    time_zone = weather_data[:timezone]
    weather_data[:hourly].map do |weather_hour|
      WeatherHourly.new(weather_hour, units, time_zone)
    end
  end

  def build_daily_weather(weather_data, units)
    time_zone = weather_data[:timezone]
    weather_data[:daily].map do |weather_day|
      WeatherDaily.new(weather_day, units, time_zone)
    end
  end
end
