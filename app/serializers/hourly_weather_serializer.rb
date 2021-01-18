class HourlyWeatherSerializer
  def self.serialize(data)
    {
      "time": data.time,
      "temp": data.temp,
      "wind_speed": data.wind_speed,
      "wind_direction": data.wind_direction,
      "description": data.description,
      "icon": data.icon
    }
  end
end
