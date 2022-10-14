class OrdersController < ApplicationController
  def index
    @orders = collection
    @order = Order.new
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new orders_params
    if @order.save!
      redirect_to orders_path, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  def edit
    @order = resource
  end

  def update
    @order = resource

    if @order.update orders_params
      redirect_to orders_path, notice: 'order was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @order = resource
    @orders = Order.where(order_id: @order.id)
    @orders.each do |order|
      order.destroy
    end

    @order.destroy
    redirect_to orders_path, notice: 'order was successfully destroyed.'
  end

  def show
    @order = resource
  end

  private

  def collection
    Order.all
  end

  def resource
    collection.find(params[:id])
  end

  def orders_params
    params.permit(:first_name, :last_name, :phone, :address, product_ids: [])
  end
end
