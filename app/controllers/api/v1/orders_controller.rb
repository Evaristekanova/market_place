class API::V1::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_order, only: [:show, :update, :destroy]

  def index
    @orders = @user.orders
    orders_json =  OrderSerializer.new(@orders).serializable_hash[:data].map{|p| p[:attributes]}
  end

  def show
    render json: OrderSerializer.new(@order).serializable_hash[:data][:attributes], status: :ok
  end

  def create
    @order = @user.orders.create!(order_params.merge(user_id: @user.id))
    render json: OrderSerializer.new(@order).serializable_hash[:data][:attributes], status: :created
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
    @order = @user.orders.find(params[:id])
  end

  def order_params
    params.fetch(:order_date, :total_amount)
  end

  def authenticate_user!
    render json: { errors: "You're not authorized to perform this action" }, status: :unauthorized unless current_user.present?
  end

  def set_user
    @user = current_user
  end

end