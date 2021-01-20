class BusinessService
  def self.conn
    Faraday.new(url: ENV['BUSINESS_SERVICE']) do |req|
      req.headers['Authorization'] = ENV['BUSINESS_API_KEY']
    end
  end

  def self.search_business(params)
    response = conn.get('/v3/businesses/search') do |req|
      req.params['location'] = params[:destination]
      req.params['term'] = params[:food]
      req.params['sort_by'] = 'rating'
      req.params['limit'] = 1
    end
    parse_data(response, params)
  end

  def self.parse_data(response, params)
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end
