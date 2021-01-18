class WeatherFacade
  def self.retrieve_weather(query, units)
    lat_lon = retrieve_coordinates(query)
    return lat_lon if lat_lon[:error]

    response = WeatherService.weather_search(lat_lon)
    WeatherLocation.new(response, units)
  end

  def self.retrieve_coordinates(query)
    response = LocationService.location_search(query)
    return response if response[:error]
    send_params = Hash.new
    send_params[:lat] = response[:results][0][:locations][0][:latLng][:lat]
    send_params[:lon] = response[:results][0][:locations][0][:latLng][:lng]
    send_params
  end
end
