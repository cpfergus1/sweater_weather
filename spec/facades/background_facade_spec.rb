require 'rails_helper'

describe 'BackgroundFacade' do
  describe 'retrieve_background' do
    it 'returns a background image and other pertinent data for use', :vcr do
      params = {location: 'denver,co'}
      response = BackgroundFacade.retrieve_background(params)
      expect(response).to be_a(Background)
      expect(response.bing_logo).to be_a(String)
      expect(response.microsoft_privacy_agreement).to be_a(String)
      expect(response.image).to be_a(String)
      expect(response.width).to be_a(Integer)
      expect(response.height).to be_a(Integer)
      expect(response.host_page).to be_a(String)
      expect(response.host_page_display).to be_a(String)
    end

    it 'returns an error when passed a bad query', :vcr do
        params = {
        location: '@#$()*&%'
      }
      response = BackgroundFacade.retrieve_background(params)
      expect(response.keys).to eq([:error, :messages])
    end

    it 'returns an error when passed no query', :vcr do
        params = {
        location: ''
      }
      response = BackgroundFacade.retrieve_background(params)
      expect(response.keys).to eq([:error, :messages])
    end
  end
end
