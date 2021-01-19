require 'rails_helper'

describe WeatherLocation, type: :poros do
  before :each do
    file_contents = File.read('./spec/fixtures/weather_location_fixture.json')
    sample_pull = JSON.parse(file_contents, symbolize_names: true)
    @sample_pull = JSON.parse(sample_pull, symbolize_names: true)
  end

  it 'exists' do
    units = 'metric'
    current_day = WeatherLocation.new(@sample_pull, units)
    expect(current_day).to be_a WeatherLocation
    expect(current_day.temp).to eq(5.44)
    expect(current_day.day_feels_like).to eq(2.58)
    expect(current_day.description).to eq('overcast clouds')
    expect(current_day.date).to eq("2021-01-17 10:50:38 -0700")
    expect(current_day.sunrise).to eq("2021-01-17 07:18:07 -0700")
    expect(current_day.sunset).to eq("2021-01-17 17:01:48 -0700")
    expect(current_day.clouds).to eq(100)
    expect(current_day.humidity).to eq(49)
    expect(current_day.uvi).to eq(1.59)
    expect(current_day.hourly_weather).to be_a(Array)
    expect(current_day.hourly_weather.length).to eq(48)
    expect(current_day.hourly_weather[0]).to be_a(WeatherHourly)
    expect(current_day.daily_weather).to be_a(Array)
    expect(current_day.daily_weather.length).to eq(8)
    expect(current_day.daily_weather[0]).to be_a(WeatherDaily)
  end

  it 'can also deliver fahrenheit' do
    units = 'imperial'
    current_day = WeatherLocation.new(@sample_pull, units)
    expect(current_day.temp).to eq(41.79)
  end

end
