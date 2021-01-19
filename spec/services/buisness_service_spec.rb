require 'rails_helper'

describe '.class_methods' do
  it 'BusinessService returns a restaurant on search_buisness', :vcr do
    params = {
      destination: 'denver,co',
      food: 'chinese'
    }
    search = BusinessService.search_business(params)
    expect(search).to be_a(Hash)
    expect(search[:businesses]).to be_a(Array)
    expect(search[:businesses][0]).to be_a(Hash)
    expect(search[:businesses][0][:name]).to be_a(String)
    expect(search[:businesses][0][:review_count]).to be_a(Integer)
    expect(search[:businesses][0][:location]).to be_a(Hash)
    expect(search[:businesses][0][:location][:address1]).to be_a(String)
    expect(search[:businesses][0][:location][:display_address]).to be_a(Array)
    expect(search[:businesses][0][:location][:display_address][0]).to be_a(String)
  end
end
