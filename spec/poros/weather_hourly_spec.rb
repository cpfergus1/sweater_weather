require 'rails_helper'

describe WeatherHourly, type: :poros do
  before :each do
    file_contents = File.read('./spec/fixtures/weather_hourly_fixture.json')
    sample_pull = JSON.parse(file_contents, symbolize_names: true)
    @sample_pull = JSON.parse(sample_pull, symbolize_names: true)
  end

  it 'exists' do
    units = 'metric'
    time_zone = 'America/Denver'
    hourly_data = WeatherHourly.new(@sample_pull, units, time_zone)
    expect(hourly_data).to be_a WeatherHourly
    expect(hourly_data.temp).to eq(5.44)
    expect(hourly_data.description).to eq('overcast clouds')
    expect(hourly_data.time).to eq("10:00:00")
    expect(hourly_data.wind_speed).to eq(2.7)
    expect(hourly_data.wind_direction).to eq('SW')
    expect(hourly_data.icon).to eq('04d')

  end

  it 'can also deliver fahrenheit and time zones change' do
    units = 'imperial'
    time_zone = 'Asia/Tokyo'
    hourly_data = WeatherHourly.new(@sample_pull, units, time_zone)
    expect(hourly_data.temp).to eq(41.79)
    expect(hourly_data.time).to eq("02:00:00")
  end

end
