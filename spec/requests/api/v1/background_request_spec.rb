require 'rails_helper'

describe 'background API' do
  it 'sends a background', :vcr do
    get '/api/v1/backgrounds?location="denver,co"'
    expect(response).to be_successful
    background = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(background).to be_a(Hash)
    expect(background[:attributes]).to be_a(Hash)
    expect(background[:attributes][:bing_logo]).to be_a(String)
    expect(background[:attributes][:microsoft_privacy_agreement]).to be_a(String)
    expect(background[:attributes][:image]).to be_a(String)
    expect(background[:attributes][:width]).to be_a(Integer)
    expect(background[:attributes][:height]).to be_a(Integer)
    expect(background[:attributes][:host_page]).to be_a(String)
    expect(background[:attributes][:host_page_display]).to be_a(String)
  end

  it 'sends an error when the query params are bad', :vcr do
    get '/api/v1/backgrounds?location="@@@@"'
    expect(response).to_not be_successful
    background = JSON.parse(response.body, symbolize_names: true)
    expect(background.keys).to eq([:error, :status])
    expect(background[:error]).to include("Invalid Search Request")
  end
end
