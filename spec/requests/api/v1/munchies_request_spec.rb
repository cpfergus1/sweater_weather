require 'rails_helper'

describe 'Munchies API' do
  it 'sends a weather forecast' do
    VCR.use_cassette('./spec/fixtures/vcr_cassettes/munchies/munchies') do
      VCR.use_cassette('road_trip_request/munchies/roadtrip') do
        VCR.use_cassette('road_trip_request/munchies/weather') do
          get '/api/v1/munchies?origin=denver,co&destination=pueblo&food=chinese&units=imperial'
          expect(response).to be_successful
          munchies = JSON.parse(response.body, symbolize_names: true)[:data]
          expect(munchies).to be_a(Hash)
          expect(munchies[:attributes]).to be_a(Hash)
          expect(munchies[:attributes][:destination_city]).to be_a(String)
          expect(munchies[:attributes][:travel_time]).to be_a(String)
          expect(munchies[:attributes][:weather_at_eta]).to be_a(Hash)
          expect(munchies[:attributes][:weather_at_eta][:temperature]).to be_a(Float)
          expect(munchies[:attributes][:weather_at_eta][:conditions]).to be_a(String)
          expect(munchies[:attributes][:restaurant]).to be_a(Hash)
          expect(munchies[:attributes][:restaurant][:name]).to be_a(String)
          expect(munchies[:attributes][:restaurant][:address]).to be_a(String)
       end
      end
    end
  end

  it "returns an error for a bad destination", :vcr do

    get '/api/v1/munchies?origin=denver,co&destination=!!!!&food=chinese&units=imperial'
    expect(response).to_not be_successful
    expect(response.status).to be >= 400
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to_not be_empty
  end

  it "returns an error for a empty destination", :vcr do

    get '/api/v1/munchies?origin=denver,co&destination=&food=chinese&units=imperial'
    expect(response).to_not be_successful
    expect(response.status).to be >= 400
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to_not be_empty
  end

  it "returns an error for routefacade failure", :vcr do

    get '/api/v1/munchies?origin=,co&destination=&food=chinese&units=imperial'
    expect(response).to_not be_successful
    expect(response.status).to be >= 400
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to_not be_empty
  end

  it "returns an random restaurant for no food input", :vcr do

    get '/api/v1/munchies?origin=,co&destination=denver&food=&units=imperial'
    expect(response).to be_successful
    munchies = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(munchies).to be_a(Hash)
    expect(munchies[:attributes]).to be_a(Hash)
    expect(munchies[:attributes][:destination_city]).to be_a(String)
    expect(munchies[:attributes][:travel_time]).to be_a(String)
    expect(munchies[:attributes][:weather_at_eta]).to be_a(Hash)
    expect(munchies[:attributes][:weather_at_eta][:temperature]).to be_a(Float)
    expect(munchies[:attributes][:weather_at_eta][:conditions]).to be_a(String)
    expect(munchies[:attributes][:restaurant]).to be_a(Hash)
    expect(munchies[:attributes][:restaurant][:name]).to be_a(String)
    expect(munchies[:attributes][:restaurant][:address]).to be_a(String)
  end

  it "returns an error for bad food input", :vcr do

    get '/api/v1/munchies?origin=,co&destination=pueblo&food=dondondon&units=imperial'
    expect(response).to_not be_successful
    expect(response.status).to be >= 400
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to_not be_empty
  end

  it "returns an error for bad start origin", :vcr do

    get '/api/v1/munchies?origin=&destination=pueblo&food=chinese&units=imperial'
    expect(response).to_not be_successful
    expect(response.status).to be >= 400
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to_not be_empty
  end
end
