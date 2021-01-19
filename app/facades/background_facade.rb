class BackgroundFacade
  def self.retrieve_background(params)
    response = ImageService.image_search(params)
    return response if response[:error]

    Background.new(response)
  end
end
