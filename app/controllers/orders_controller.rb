class OrdersController < ApplicationController
  def index
    # @orders = collection
    @order = Order.new
  end

  def create
    @order = Order.new orders_params
    if @order.save
      redirect_to root_path, notice: 'Order was successfully created.'
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def orders_params
    params.permit(:first_name, :last_name, :phone, :address, product_ids: [])
  end
end
