class WeatherSerializer
  include FastJsonapi::ObjectSerializer
  set_id :id
  set_type "forecast"
  attributes  :temp,
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
              :icon

  attributes :hourly_weather do |weather|
    weather.hourly_weather.map do |hour|
      HourlyWeatherSerializer.serialize(hour)
    end
  end

  attributes :daily_weather do |weather|
    weather.daily_weather.map do |day|
      DailyWeatherSerializer.serialize(day)
    end
  end

end
