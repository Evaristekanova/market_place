class API::V1::OrderItemsController < ApplicationController
  def create
    @order_item = OrderItem.create!(order_item_params)
    render json: @order_item, status: :created
  end

  def update
    @order_item.update!(order_item_params)
    render json: @order_item, status: :ok
  end

  private

  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def order_item_params
    params.require(:order_item).permit(:order_id, :product_id, :quantity)
  end
end
