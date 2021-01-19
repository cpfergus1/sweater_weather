describe '.class_methods' do
  it 'image_search method returns parsed response based on params', :vcr do
    params = {
      location: 'denver,co'
    }
    search = ImageService.image_search(params)

    expect(search).to be_a(Hash)
    expect(search.keys).to eq([:_type,
                              :instrumentation,
                              :readLink,
                              :webSearchUrl,
                              :queryContext,
                              :totalEstimatedMatches,
                              :nextOffset,
                              :currentOffset,
                              :value,
                              :queryExpansions,
                              :pivotSuggestions,
                              :relatedSearches])
    expect(search[:value]).to be_an(Array)
    expect(search[:value].count).to eq(5)
    expect(search[:value][0]).to be_a(Hash)
    expect(search[:value][0].keys).to eq([:webSearchUrl,
                                        :name,
                                        :thumbnailUrl,
                                        :datePublished,
                                        :isFamilyFriendly,
                                        :contentUrl,
                                        :hostPageUrl,
                                        :contentSize,
                                        :encodingFormat,
                                        :hostPageDisplayUrl,
                                        :width,
                                        :height,
                                        :hostPageFavIconUrl,
                                        :hostPageDomainFriendlyName,
                                        :hostPageDiscoveredDate,
                                        :thumbnail,
                                        :imageInsightsToken,
                                        :insightsMetadata,
                                        :imageId,
                                        :accentColor]
                                        )
    expect(search[:value][0][:contentUrl]).to be_a(String)
  end

  it 'returns an error when it has an unknown query', :vcr do
    params = {
        location: '@#$()*&%'
      }
    search = ImageService.image_search(params)

    expect(search.keys).to eq([:error, :messages])
  end

  it 'returns an error when query is blank', :vcr do
    params = {
        location: ''
      }
    search = ImageService.image_search(params)

    expect(search.keys).to eq([:error, :messages])
  end
end
