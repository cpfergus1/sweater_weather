module Api
  module V1
    class MunchiesController < ApplicationController
      def index
        munchies = MunchiesFacade.deliver_munchies(request_params)
        return error_check(munchies) unless munchies.is_a?(Munchies)

        render json: MunchiesSerializer.new(munchies), status: :ok
      end

      private

      def request_params
        params[:units] = 'metric' unless params[:units]
        params.permit(:origin, :destination, :food, :units)
      end

      def error_check(returned_request)
        if returned_request[:businesses]
          render json: {messages: "Cannot find any buisnesses with associated request"}, status: :bad_request
        elsif returned_request[:error]
          message = {messages: returned_request[:error][:description]}
          render json: message, status: 400
        else
          render json: returned_request[:messages], status: returned_request[:statuscode]
        end
      end
    end
  end
end
