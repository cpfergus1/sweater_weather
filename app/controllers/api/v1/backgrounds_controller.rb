module Api
  module V1
    class BackgroundsController < ApplicationController
      def index
        background = BackgroundFacade.retrieve_background(request_params)
        if background.instance_of?(Hash)
          payload = {
            error: background[:messages],
            status: background[:error]
          }

          render json: payload, status: :bad_request
          return
        end
        render json: BackgroundSerializer.new(background)
      end

      private

      def request_params
        params.permit(:location)
      end
    end
  end
end
