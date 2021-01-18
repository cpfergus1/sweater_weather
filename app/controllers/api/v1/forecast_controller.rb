module Api
  module V1
    class ForecastController < ApplicationController
      def index
        weather = WeatherFacade.retrieve_weather(request_params)
        if weather.instance_of?(Hash)
          payload = {
            error: weather[:messages],
            status: weather[:error]
          }

          render json: payload, status: :bad_request
          return
        end
        render json: WeatherSerializer.new(weather)
      end

      private

      def request_params
        params[:units] = 'metric' unless params[:units]
        params.permit(:location, :units)
      end
    end
  end
end
