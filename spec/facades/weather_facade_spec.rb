require 'rails_helper'

describe 'ServicesFacade' do
  describe '.class_methods' do
    before :each do
      @params = Hash.new
    end
    it 'can return lat_lon from retrieve_coordinates', :vcr do
      @params[:location] = 'washington,D.C.'
      return_response = WeatherFacade.retrieve_coordinates(@params)
      expect(return_response[:lat]).to eq(38.892062)
      expect(return_response[:lon]).to eq(-77.019912)
    end

    it 'will return and error if params is bad', :vcr do
      @params[:location] = '/@#%(@*%&'
      return_response = WeatherFacade.retrieve_coordinates(@params)
      expect(return_response.keys).to eq([:error, :messages])
    end

    it 'will pull weather for fed coordinates to retrieve weather', :vcr do
      @params[:location] = 'washington,D.C.'
      units = 'imperial'
      return_response = WeatherFacade.retrieve_weather(@params, units)
      expect(return_response).to be_a(WeatherLocation)
    end

    it 'will return and error if bad query', :vcr do
       @params[:location] = '/@#%(@*%&'
       units = 'imperial'
      return_response = WeatherFacade.retrieve_weather(@params, units)
      expect(return_response.keys).to eq([:error, :messages])
    end
  end
end
