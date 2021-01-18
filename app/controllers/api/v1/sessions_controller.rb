module Api
  module V1
    class SessionsController < ApplicationController
      def login
        user = User.find_by(email: login_params[:email])
        if user && user.authenticate(login_params[:password])
           render json: UserSerializer.new(user), status: :ok
        else
          errors = find_errors(user)
          render json: errors[:error_message], status: errors[:status_code]
        end
      end

      private

      def find_errors(user)
        if user
          return_errors = {error_message: { messages: "E-mail or Password are incorrect"} }
          return_errors[:status_code] = :bad_request
        else
          return_errors = {error_message: { messages: "User Not Found"} }
          return_errors[:status_code] = :not_found
        end
        return_errors
      end

      def login_params
        params.permit(:email, :password)
      end

    end
  end
end
