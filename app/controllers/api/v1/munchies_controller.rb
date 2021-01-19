module Api
  module V1
    class MunchiesController < ApplicationController
      def index
        munchies_info = BusinessService.search_business(request_params)
        travel_info = RoutesFacade.search_routes(request_params)
        munchies = Munchies.new(munchies_info, travel_info)
        render json: MunchiesSerializer.new(munchies), status: :ok
      end

      private

      def request_params
        params[:units] = 'metric' unless params[:units]
        params.permit(:origin, :destination, :food, :units)
      end
    end
  end
end
