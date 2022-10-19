class ProductsController < ApplicationController
  # GET /products or /products.json
  def index
    @products = collection
    # @cart = initialize_cart
    @order = initialize_order
  end

  # GET /products/1 or /products/1.json
  def show
    @product = resource
    # @cart = initialize_cart
  end

  # GET /products/new
  def new
    @product = Product.new
    # @cart = initialize_cart
  end

  # GET /products/1/edit
  def edit
    @product = resource
    # @cart = initialize_cart
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to product_url(@product), notice: 'Product was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    @product = resource

    if @product.update(product_params)
      redirect_to product_url(@product), notice: 'Product was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product = resource
    if session[:cart].exclude?(@product.id)
      @product.destroy
      flash[:notice] = 'Product was successfully destroyed.'
    else
      flash[:notice] = 'The product cannot be removed, it is in the shopping cart.'
    end

    redirect_to root_path
  end

  def add_to_cart
    id = params[:id].to_i
    session[:cart] << id unless session[:cart].include?(id)

    redirect_to root_path, notice: 'Product was successfully added to cart.'
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)

    redirect_to root_path, notice: 'Product was successfully removed.'
  end

  private

  def collection
    Product.all
  end

  def resource
    collection.find(params[:id])
  end

  def initialize_order
    Order.new
  end

  def product_params
    params.require(:product).permit(:name, :category_id, :price, :description, :status)
  end
end
