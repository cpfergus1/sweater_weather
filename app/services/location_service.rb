class LocationService
  def self.conn
    Faraday.new(url: ENV['LOCATION_SERVICE'])
  end

  def self.location_search(params)
    response = conn.get('/geocoding/v1/address') do |req|
      req.params['key'] = ENV["LOCATION_API_KEY"]
      req.params['location'] = params[:location]
    end
    parse_data(response, params)
  end

  def self.parse_data(response, params)
    if response.body.empty?
      { :error => 400, :messages => "Unknown Location: #{params[:location]}"}
    else
      JSON.parse(response.body, symbolize_names: true)
    end
  end

  def self.get_directions(params)
      response = conn.get('/directions/v2/route') do |req|
      req.params['key'] = ENV["LOCATION_API_KEY"]
      req.params['from'] = params[:origin]
      req.params['to'] = params[:destination]
    end
    parse_data(response, params)
  end
end
