class Munchies
  attr_reader :destination_city,
              :travel_time,
              :weather_at_eta,
              :restaurant,
              :id

  def initialize(business_data, road_trip)
    @destination_city = road_trip.end_city
    @travel_time = road_trip.travel_time
    @weather_at_eta = road_trip.weather_at_eta
    @restaurant = address_return(business_data)
  end

  def address_return(business_data)
    {
      name: business_data[:businesses][0][:name],
      address: business_data[:businesses][0][:location][:display_address].join(', ')
    }
  end
end
