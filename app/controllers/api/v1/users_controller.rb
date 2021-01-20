
module Api
  module V1
    class UsersController < ApplicationController
      def create
        user = User.new(user_params)
        if user.save
          render json: UserSerializer.new(user), status: :created
        else
          render json: generate_error(user), status: :bad_request
        end
      end

      private

      def user_params
        params[:api_key] = SecureRandom.base64(14)
        params[:email] = params[:email].downcase
        params.permit(:email, :password, :password_confirmation, :api_key)
      end

      def generate_error(user)
        { messages: user.errors.full_messages.to_sentence}
      end
    end
  end
end
