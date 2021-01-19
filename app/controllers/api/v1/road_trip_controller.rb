module Api
  module V1
    class RoadTripController < ApplicationController
      def create
        return render json: api_error, status: :unauthorized if bad_api

        road_trip = RoutesFacade.search_routes(request_params)
        if road_trip.is_a?(Hash)
          render json: road_trip, status: road_trip[:statuscode]
        else
          render json: RoadtripSerializer.new(road_trip)
        end
      end

      private

      def request_params
        params[:units] = 'metric' unless params[:units]
        params.permit(:origin, :destination, :api_key, :units)
      end

      def bad_api
        params[:api_key] == '' || User.find_by(api_key: params[:api_key]).nil?
      end

      def api_error
        {
          statuscode: 401,
          messages: ['User Unauthorized']
        }
      end
    end
  end
end
