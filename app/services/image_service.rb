class ImageService
  def self.conn
    Faraday.new(url: ENV['IMAGE_SERVICE']) do |req|
      req.headers['Ocp-Apim-Subscription-Key'] = ENV['IMAGE_API_KEY']
    end
  end

  def self.image_search(params)
    response = conn.get('/v7.0/images/search') do |req|
      req.params['q'] = params[:location]
      req.params['count'] = 5
    end
    parse_data(response, params)
  end

  def self.parse_data(response, params)
    parsed = JSON.parse(response.body, symbolize_names: true)
    if parsed[:errors] || parsed[:value] == []
      { error: 400, messages: "Invalid Search Request: #{params[:location]}"}
    else
      parsed
    end
  end
end
