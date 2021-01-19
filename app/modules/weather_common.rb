module WeatherCommon
  def fahrenheit(temp)
    (((temp - 273.15) * 9 / 5) + 32).round(2)
  end

  def celsius(temp)
    (temp - 273.15).round(2)
  end

  def requested_temp(units, data_loc)
    units == 'metric' ? celsius(data_loc) : fahrenheit(data_loc)
  end

  def convert_time(time, time_zone)
    Time.at(time).in_time_zone(time_zone).strftime('%Y-%m-%d %H:%M:%S %z')
  end
end
