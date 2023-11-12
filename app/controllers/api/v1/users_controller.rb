class API::V1::UsersController < APIController
    before_action :authenticate_user, except: %i[create]
    before_action :set_user except: %i[create]

    def show
        render json: UserSerializer.new(@user).serializable_hash[:data][:attributes], status: :ok
    end

    def create
        @user = User.create!(user_params)
        render json: UserSerializer.new(@user).serializable_hash[:data][:attributes], status: :created
    end

    def update
        @user.update!(user_params)
        render json: UserSerializer.new(@user).serializable_hash[:data][:attributes], status: :ok
    end

    def destroy
        @user.destroy
        head :no_content
    end

    private

    def user_params
        params.permit(:email, :first_name, :last_name, :phone, :password)
    end

    def set_user
        @user = current_user
    end

    def authenticate_user
        render json: { errors: "You're not authorized to perform this action" }, status: :unauthorized unless current_user.present?
    end
end
