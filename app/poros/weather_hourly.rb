require './app/modules/weather_common'
class WeatherHourly
  include WeatherCommon
  attr_reader :time,
              :temp,
              :wind_speed,
              :wind_direction,
              :description,
              :icon

  def initialize(weather_data, units = 'metric', time_zone = 'America/Denver')
    @time = Time.at(weather_data[:dt]).in_time_zone(time_zone).strftime('%H:%M:%S')
    @temp = requested_temp(units, weather_data[:temp])
    @wind_speed = weather_data[:wind_speed]
    @wind_direction = wind_direction_compass(weather_data[:wind_deg])
    @description = weather_data[:weather][0][:description]
    @icon = weather_data[:weather][0][:icon]
  end

  private

  def wind_direction_compass(data)
    sections = ['N',
                'NNE',
                'NE',
                'ENE',
                'E',
                'ESE',
                'SE',
                'SSE',
                'S',
                'SSW',
                'SW',
                'WSW',
                'W',
                'WNW',
                'NW',
                'NNW',
                'N']
    number_to_string_conversion = (data % 360 / 22.5).round(0) + 1
    sections[number_to_string_conversion]
  end
end
