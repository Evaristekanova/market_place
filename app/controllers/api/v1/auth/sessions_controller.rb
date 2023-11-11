class API::V1::Auth::SessionsController <APIController

    def create
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
            user = UserSerializer.new(user).serializable_hash
            render json: { token: JsonWebToken.encode(user_id: user.dig(:data, :id)), user: user.dig(:data, :attributes) }, status: :ok
        else
            render json: { errors: 'Invalid email or password' }, status: :unauthorized
        end
    end
end
