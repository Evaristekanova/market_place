class API::V1::OrderItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_item, only: [:show, :update, :destroy]


  def index
    @order_items = OrderItem.all
    order_items_json =  OrderItemSerializer.new(@order_items).serializable_hash[:data].map{|p| p[:attributes]}
    render json: { data: order_items_json }, status: :ok
  end

  def create
    @order_item = OrderItem.create!(order_item_params)
    render json: OrderItemSerializer.new(@order_item).serializable_hash[:data][:attributes], status: :ok
  end

  def update
    @order_item.update!(order_item_params)
    render json: OrderItemSerializer.new(@order_item).serializable_hash[:data][:attributes], status: :ok
  end

  def destroy
    @order_item.destroy
    head :no_content
  end

  private

  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def order_item_params
    params.require(:order_item).permit(:order_id, :product_id, :quantity)
  end

  def authenticate_user!
    render json: { errors: "You're not authorized to perform this action" }, status: :unauthorized unless current_user.present?
  end
end
