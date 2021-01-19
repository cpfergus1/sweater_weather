class MunchiesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :destination_city,
             :travel_time,
             :weather_at_eta,
             :restaurant
end
