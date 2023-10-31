class APIController < ActionController::API
    def market_ckech
        render json: {message: "Ok"}, status: :ok
    end
end