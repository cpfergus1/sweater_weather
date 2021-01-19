module Api
  module V1
    class MunchiesController < ApplicationController
      def index
        munchies = MunchiesFacade.deliver_munchies(request_params)
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
