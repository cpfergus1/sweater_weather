class LocationService
  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com')
  end

  def self.location_search(params)
    response = conn.get('/geocoding/v1/address') do |req|
      req.params['key'] = ENV["LOCATION_API_KEY"]
      req.params['location'] = params[:location]
    end
    parse_data(response, params)
  end

  def self.parse_data(response,params)
    if response.body.empty?
      { :error => 400, :messages => "Unknown Location: #{params[:location]}"}
    else
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
