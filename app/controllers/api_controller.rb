class APIController < ActionController::API
include Authenticable
include ErrorHandler
rescue_from StandardError, with: :error_handler
    def market_ckech
        render json: {message: "Ok"}, status: :ok
    end
end