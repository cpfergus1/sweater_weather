require 'rails_helper'

describe '.class_methods' do
  it 'yelp returns a restaurant on search_buisness', :vcr do
    params = {
      destination: 'denver,co'
      food: 'chinese'
    }
    search = BuisnessService.search_buiness(params)
    expect(search).to be_a(Hash)
    expect(search[:buisnesses]).to be_a(Array)
    expect(search[:buisnesses][0]).to be_a(Hash)
    expect(search[:buisnesses][0][:name]).to be_a(String)
    expect(search[:buisnesses][0][:review_count]).to be_a(Integer)
    expect(search[:buisnesses][0][:location]).to be_a(Hash)
    expect(search[:buisnesses][0][:location][:address1]).to be_a(String)
    expect(search[:buisnesses][0][:location][:display_address]).to be_a(String)
  end
end
