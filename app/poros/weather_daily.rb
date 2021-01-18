require './app/modules/weather_common'

class WeatherDaily

  include WeatherCommon

  attr_reader :min_temp,
              :max_temp,
              :description,
              :date,
              :sunset,
              :sunrise,
              :description,
              :icon

  def initialize(weather_data, units, time_zone)
    @date = DateTime.strptime(weather_data[:dt].to_s, '%s').strftime('%Y-%m-%d')
    @max_temp = requested_temp(units, weather_data[:temp][:max])
    @min_temp = requested_temp(units, weather_data[:temp][:min])
    @description = weather_data[:weather][0][:description]
    @sunset = convert_time(weather_data[:sunset], time_zone)
    @sunrise = convert_time(weather_data[:sunrise], time_zone)
    @description = weather_data[:weather][0][:description]
    @icon = weather_data[:weather][0][:icon]
  end
end
