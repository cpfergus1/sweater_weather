require 'rails_helper'

describe WeatherDaily, type: :poros do
  before :each do
    file_contents = File.read('./spec/fixtures/weather_daily_fixture.json')
    sample_pull = JSON.parse(file_contents, symbolize_names: true)
    @sample_pull = JSON.parse(sample_pull, symbolize_names: true)
  end

  it 'exists' do
    units = 'metric'
    time_zone = 'America/Denver'
    daily_data = WeatherDaily.new(@sample_pull, units, time_zone)
    expect(daily_data).to be_a WeatherDaily
    expect(daily_data.max_temp).to eq(8.93)
    expect(daily_data.min_temp).to eq(1.63)
    expect(daily_data.description).to eq('clear sky')
    expect(daily_data.date).to eq("2021-01-21")
    expect(daily_data.sunrise).to eq("2021-01-21 07:16:00 -0700")
    expect(daily_data.sunset).to eq("2021-01-21 17:06:21 -0700")
    expect(daily_data.icon).to eq('01d')

  end

  it 'can also deliver fahrenheit and time zones change' do
    units = 'imperial'
    time_zone = 'Asia/Tokyo'
    daily_data = WeatherDaily.new(@sample_pull, units, time_zone)
    expect(daily_data.max_temp).to eq(48.07)
    expect(daily_data.sunrise).to eq("2021-01-21 23:16:00 +0900")
  end

end
