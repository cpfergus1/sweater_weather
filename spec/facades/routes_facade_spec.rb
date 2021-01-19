require 'rails_helper'

describe 'RoutesFacade' do
  describe 'search_routes' do
    it 'returns a roadtrip object' do
      VCR.use_cassette('./spec/fixtures/vcr_cassettes/RoutesFacade/search_routes/returns_a_roadtrip_object.yml') do
        VCR.use_cassette('weather_object.yml') do
          params = { origin: 'denver,co',
                  destination: 'pueblo,co',
                  units: 'imperial' }
          response = RoutesFacade.search_routes(params)
          expect(response).to be_a Roadtrip
          expect(response.start_city).to be_a(String)
          expect(response.end_city).to be_a(String)
          expect(response.travel_time).to be_a(String)
          expect(response.weather_at_eta).to be_a(Hash)
          expect(response.weather_at_eta[:temperature]).to be_a(Float)
          expect(response.weather_at_eta[:conditions]).to be_a(String)
        end
      end
    end

    it 'returns an error when passed a bad query', :vcr do
      params = {
                origin: 'john john',
                destination: 'knick knick'
                }
      response = RoutesFacade.search_routes(params)
      expect(response.keys).to eq([:statuscode, :copyright, :messages])
      expect(response[:messages][0]).to include('We are unable to route with the given locations.')
    end

    it 'returns an error when passed no query', :vcr do
      params = {
                origin: '',
                destination: ''
                }
      response = RoutesFacade.search_routes(params)
      expect(response.keys).to eq([:statuscode, :copyright, :messages])
      expect(response[:messages][0]).to include('At least two locations must be provided')
    end
  end
end
