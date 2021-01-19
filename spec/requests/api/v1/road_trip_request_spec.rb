require 'rails_helper'

describe 'road_trip API' do
  it 'sends a roadtrip' do
    VCR.use_cassette('./spec/fixtures/vcr_cassettes/road_trip_request/returns_a_roadtrip_object.yml') do
      VCR.use_cassette('road_trip_request/weather_object.yml') do
        User.create!({ email: "email@email.com",
                   password: "abc123",
                   password_confirmation: "abc123",
                   api_key: 'I-AM-A-API-KEY'})

        headers = {'CONTENT_TYPE' => 'application/json'}
        json_payload = { origin: "denver,co",
                         destination: "fairbanks,AK",
                         api_key: 'I-AM-A-API-KEY',
                         units: 'imperial' }

        post '/api/v1/road_trip', headers: headers, params: JSON.generate(json_payload)
        expect(response).to be_successful
        road_trip = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(road_trip).to be_a(Hash)
        expect(road_trip[:attributes]).to be_a(Hash)
        expect(road_trip[:attributes][:start_city]).to be_a(String)
        expect(road_trip[:attributes][:end_city]).to be_a(String)
        expect(road_trip[:attributes][:travel_time]).to be_a(String)
        expect(road_trip[:attributes][:weather_at_eta]).to be_a(Hash)
        expect(road_trip[:attributes][:weather_at_eta][:temperature]).to be_a(Float)
        expect(road_trip[:attributes][:weather_at_eta][:conditions]).to be_a(String)
      end
    end
  end

  it "returns an error for a bad destination", :vcr do
    User.create!({ email: "email@email.com",
                  password: "abc123",
                  password_confirmation: "abc123",
                  api_key: 'I-AM-A-API-KEY'})

    headers = {'CONTENT_TYPE' => 'application/json'}
    json_payload = { origin: "#$%*&",
                      destination: "knack knack",
                      api_key: 'I-AM-A-API-KEY',
                      units: 'imperial' }

    post '/api/v1/road_trip', headers: headers, params: JSON.generate(json_payload)
    expect(response).to_not be_successful
    expect(response.status).to be >= 400
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:messages][0]).to_not be_empty
  end

  it "returns an error for a empty destination", :vcr do
    User.create!({ email: "email@email.com",
                  password: "abc123",
                  password_confirmation: "abc123",
                  api_key: 'I-AM-A-API-KEY'})

    headers = {'CONTENT_TYPE' => 'application/json'}
    json_payload = { origin: "denver,co",
                      destination: "",
                      api_key: 'I-AM-A-API-KEY',
                      units: 'imperial' }

    post '/api/v1/road_trip', headers: headers, params: JSON.generate(json_payload)
    expect(response).to_not be_successful
    expect(response.status).to be >= 400
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:messages][0]).to_not be_empty
  end

  it "returns an error for a mismatch or empty api", :vcr do
    User.create!({ email: "email@email.com",
                  password: "abc123",
                  password_confirmation: "abc123",
                  api_key: 'I-AM-A-API-KEY'})

    headers = {'CONTENT_TYPE' => 'application/json'}
    json_payload = { origin: "denver,co",
                      destination: "",
                      api_key: '',
                      units: 'imperial' }

    post '/api/v1/road_trip', headers: headers, params: JSON.generate(json_payload)
    expect(response).to_not be_successful
    expect(response.status).to be >= 400
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:messages][0]).to_not be_empty

    headers = {'CONTENT_TYPE' => 'application/json'}
    json_payload = { origin: "denver,co",
                      destination: "",
                      api_key: '123',
                      units: 'imperial' }

    post '/api/v1/road_trip', headers: headers, params: JSON.generate(json_payload)
    expect(response).to_not be_successful
    expect(response.status).to be >= 400
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:messages][0]).to_not be_empty
  end
end
