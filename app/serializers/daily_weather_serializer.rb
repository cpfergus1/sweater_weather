class DailyWeatherSerializer
  def self.serialize(data)
    {
      "date": data.date,
      "max_temp": data.max_temp,
      "min_temp": data.min_temp,
      "description": data.description,
      "sunset": data.sunset,
      "sunrise": data.sunrise,
      "icon": data.icon
    }
  end
end
