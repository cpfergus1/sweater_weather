require 'rails_helper'

describe '.class_methods' do
  it 'location_search method returns parsed response based on params', :vcr do
    params = {
      location: 'denver,co'
    }
    search = LocationService.location_search(params)

    expect(search).to be_a(Hash)
    expect(search[:results]).to be_an(Array)
    expect(search[:results][0]).to be_a(Hash)
    expect(search[:results][0].keys).to eq([:providedLocation, :locations])
    expect(search[:results][0][:locations]).to be_a(Array)
    expect(search[:results][0][:locations][0]).to be_a(Hash)
    expect(search[:results][0][:locations][0].keys).to eq([:street,
                                                          :adminArea6,
                                                          :adminArea6Type,
                                                          :adminArea5,
                                                          :adminArea5Type,
                                                          :adminArea4,
                                                          :adminArea4Type,
                                                          :adminArea3,
                                                          :adminArea3Type,
                                                          :adminArea1,
                                                          :adminArea1Type,
                                                          :postalCode,
                                                          :geocodeQualityCode,
                                                          :geocodeQuality,
                                                          :dragPoint,
                                                          :sideOfStreet,
                                                          :linkId,
                                                          :unknownInput,
                                                          :type,
                                                          :latLng,
                                                          :displayLatLng,
                                                          :mapUrl])
    expect(search[:results][0][:locations][0][:latLng]).to be_a(Hash)
    expect(search[:results][0][:locations][0][:latLng].keys).to eq([:lat, :lng])
    expect(search[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)
    expect(search[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
  end

  it 'returns an error if bad search params are sent forward', :vcr do
    params = {
      location: '@*^%$'
    }
    search = LocationService.location_search(params)

    expect(search).to be_a(Hash)
    expect(search[:error]).to eq(400)
    expect(search[:messages]).to eq("Unknown Location: #{params[:location]}")
  end
end
