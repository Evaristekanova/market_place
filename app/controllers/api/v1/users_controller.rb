class Api::V1::UsersController < ApiController
    before_action :set_user, only: [:show, :update, :destroy]
    before_action :user_params, only: [:create, :update]
    before_action :authenticate_user, only: [:update, :destroy]

    def index
        @users = User.all
        users_json = UserSerializer.new(@users).serializable_hash[:data].map{|hash| hash[:attributes]}
        render json: {data: users_json}, status: :ok
    end

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
        @user = User.find(params[:id])
    end

    def authenticate_user
        return current_user if current_user.present?
        render json: { errors: "You're not authorized to perform this action" }, status: :unauthorized
    end

end