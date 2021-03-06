class RoutesFacade
  def self.search_routes(params)
    location_response = LocationService.get_directions(params)
    return error_response(location_response) if conditions_met(location_response)

    weather_params = { lat_lon: { lat: location_response[:route][:locations][1][:latLng][:lat],
                                  lon: location_response[:route][:locations][1][:latLng][:lng] }
                                }
    weather_response = WeatherFacade.weather_at_dest(weather_params, params[:units])
    Roadtrip.new(location_response, weather_response)
  end

  def self.conditions_met(location_response)
    location_response[:info][:statuscode] >= 400
  end

  def self.error_response(location_response)
    {
      statuscode: location_response[:info][:statuscode],
      messages: location_response[:info][:messages]
    }
  end
end
