require 'rails_helper'

describe 'forecast API' do
  it 'sends a weather forecast', :vcr do
    get '/api/v1/forecast?location="denver,co"'
    expect(response).to be_successful
    weather_forecast = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(weather_forecast).to be_a(Hash)
    expect(weather_forecast[:attributes]).to be_a(Hash)
    expect(weather_forecast[:attributes][:temp]).to be_a(Float)
    expect(weather_forecast[:attributes][:day_feels_like]).to be_a(Float)
    expect(weather_forecast[:attributes][:description]).to be_a(String)
    expect(weather_forecast[:attributes][:date]).to be_a(String)
    expect(weather_forecast[:attributes][:clouds]).to be_a(Integer)
    expect(weather_forecast[:attributes][:sunrise]).to be_a(String)
    expect(weather_forecast[:attributes][:sunset]).to be_a(String)
    expect(weather_forecast[:attributes][:hourly_weather]).to be_a(Array)
    expect(weather_forecast[:attributes][:hourly_weather].length).to eq(48)
    expect(weather_forecast[:attributes][:daily_weather]).to be_a(Array)
    expect(weather_forecast[:attributes][:daily_weather].length).to eq(8)
  end

  it 'sends an error when the query params are bad', :vcr do
    get '/api/v1/forecast?location="@@@@"'
    expect(response).to_not be_successful
    weather_forecast = JSON.parse(response.body, symbolize_names: true)
    expect(weather_forecast.keys).to eq([:error, :status])
    expect(weather_forecast[:error]).to include("Unknown Location")
  end
end
