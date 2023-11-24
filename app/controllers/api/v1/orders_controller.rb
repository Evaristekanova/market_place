class API::V1::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]

  def index
    @orders = Order.all.order(created_at: :desc)
    render json: @orders, status: :ok
  end

  def show
    render json: @order, status: :ok
  end


  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.fetch(:order_date, :total_amount)
  end

end