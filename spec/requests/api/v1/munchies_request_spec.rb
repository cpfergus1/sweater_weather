require 'rails_helper'

describe 'Munchies API' do
  it 'sends a weather forecast' do
    VCR.use_cassette('./spec/fixtures/vcr_cassettes/munchies/munchies') do
      VCR.use_cassette('road_trip_request/munchies/roadtrip') do
        VCR.use_cassette('road_trip_request/munchies/weather') do
          get '/api/v1/munchies?origin=denver,co&destination=pueblo&food=chinese&units=imperial'
          expect(response).to be_successful
          munchies = JSON.parse(response.body, symbolize_names: true)[:data]
          expect(road_trip).to be_a(Hash)
          expect(road_trip[:attributes]).to be_a(Hash)
          expect(road_trip[:attributes][:destination_city]).to be_a(String)
          expect(road_trip[:attributes][:travel_time]).to be_a(String)
          expect(road_trip[:attributes][:weather_at_eta]).to be_a(Hash)
          expect(road_trip[:attributes][:weather_at_eta][:temperature]).to be_a(Float)
          expect(road_trip[:attributes][:weather_at_eta][:conditions]).to be_a(String)
          expect(road_trip[:attributes][:restaurant]).to be_a(Hash)
          expect(road_trip[:attributes][:restaurant][:name]).to be_a(String)
          expect(road_trip[:attributes][:restaurant][:address]).to be_a(String)
       end
      end
    end
  end
end
