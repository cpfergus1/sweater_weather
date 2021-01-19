class MunchiesFacade

  def self.deliver_munchies(params)
    munchies_info = BusinessService.search_business(params)
    return munchies_info if conditions_met(munchies_info)

    travel_info = RoutesFacade.search_routes(params)
    return travel_info if travel_info.is_a?(Hash)

    Munchies.new(munchies_info, travel_info)
  end

  def self.conditions_met(munchies_info)
    munchies_info[:error] || munchies_info[:businesses] == []
  end
end
