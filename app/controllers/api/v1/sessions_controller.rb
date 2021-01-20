module Api
  module V1
    class SessionsController < ApplicationController
      def login
        user = User.find_by(email: login_params[:email])
        if login_conditions(user)
          render json: UserSerializer.new(user), status: :ok
        else
          errors = error_return
          render json: errors[:error_message], status: errors[:status_code]
        end
      end

      private

      def error_return
        if check_empty
          return_errors = { error_message: { messages: 'E-mail or Password are incorrect' } }
          return_errors[:status_code] = :bad_request
        else
          return_errors = { error_message: { messages: 'E-mail or Password information not provided' } }
          return_errors[:status_code] = :not_found
        end
        return_errors
      end

      def check_empty
        params[:email] != '' && params[:password] != ''
      end

      def login_params
        params[:email] = params[:email].downcase
        params.permit(:email, :password)
      end

      def login_conditions(user)
        check_empty && user && user.authenticate(login_params[:password])
      end

    end
  end
end
