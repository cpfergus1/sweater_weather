class Roadtrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta,
              :id

  def initialize(route_data, weather_data)
    @start_city = address_smash(route_data, 0)
    @end_city = address_smash(route_data, 1)
    @travel_time = travel_time_calc(route_data[:route][:time])
    @weather_at_eta = weather_at_time(weather_data, route_data[:route][:time])
  end

  def address_smash(route_data, array_loc)
    location = [route_data[:route][:locations][array_loc][:steet],
                route_data[:route][:locations][array_loc][:adminArea5],
                route_data[:route][:locations][array_loc][:adminArea3],
                route_data[:route][:locations][array_loc][:adminArea1]]

    location.compact.split("").flatten.join(', ')
  end

  def travel_time_calc(sec)
    if sec == -1 || sec == 1_000_000
      'Impossible Route'
    else
      "%02d hours, %02d minutes, %02d seconds" % [sec / 3600, sec / 60 % 60, sec % 60]
    end
  end

  def weather_at_time(weather_data, sec)
    hour = (sec / 3600.to_f).ceil
    if hour <= 48
      { temperature: weather_data.hourly_weather[(hour - 1)].temp,
        conditions: weather_data.hourly_weather[(hour - 1)].description }
    elsif hour > 48 && hour <= 192
      day = (hour / 24.to_f).ceil
      { temperature: weather_data.daily_weather[(day - 1)].max_temp,
        conditions: weather_data.daily_weather[(day - 1)].description }
    else
      { temperature: 'Out of Forecast Range', conditions: 'Out of Forecast Range' }
    end
  end
end
