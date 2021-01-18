class ImageService
  def self.conn
    Faraday.new(url: 'https://api.bing.microsoft.com/') do |req|
      req.headers['Ocp-Apim-Subscription-Key'] = ENV["IMAGE_API_KEY"]
    end
  end

  def self.image_search(params)
    response = conn.get('/v7.0/images/search') do |req|
      req.params['q'] = params[:location]
      req.params['count'] = 5
    end
    parse_data(response)
  end

  def self.parse_data(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
