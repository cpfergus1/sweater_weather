class MunchiesFacade

  def self.deliver_munchies(params)
    munchies_info = BusinessService.search_business(params)
    travel_info = RoutesFacade.search_routes(params)
    Munchies.new(munchies_info, travel_info)
  end

end
