class API::V1::OrdersController < APIController
  before_action :authenticate_user!
  before_action :set_order, only: %i[show update destroy]

  def index
    @orders = current_user.orders
    orders_json =  OrderSerializer.new(@orders).serializable_hash[:data].map{|p| p[:attributes]}
    render json: { data: orders_json }, status: :ok
  end

  def show
    render json: OrderSerializer.new(@order).serializable_hash[:data][:attributes], status: :ok
  end

  def create
    @order = current_user.orders.create!(user_id: current_user.id)
    render json: OrderSerializer.new(@order).serializable_hash[:data][:attributes], status: :ok
  end

  def update
    @order.update!(order_params)
    render json: OrderSerializer.new(@order).serializable_hash[:data][:attributes], status: :ok
  end

  def destroy
    @order.destroy
    head :no_content
  end

  private

  def set_order
    @order = current_user.orders.find(params[:id])
  end

  def authenticate_user!
    render json: { errors: "You're not authorized to perform this action" }, status: :unauthorized unless current_user.present?
  end
end