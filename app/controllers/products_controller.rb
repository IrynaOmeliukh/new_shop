class ProductsController < ApplicationController
  # GET /products or /products.json
  def index
    @products = collection
  end

  # GET /products/1 or /products/1.json
  def show
    @product = resource
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    @product = resource
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

      if @product.save
      redirect_to product_url(@product), notice: "Product was successfully created."
      else
      render :new, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    @product = resource

    if @product.update(product_params)
      redirect_to product_url(@product), notice: "Product was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product = resource
    @product.destroy

    redirect_to products_url, notice: "Product was successfully destroyed."
  end

  private

    def collection
      Product.all
    end

    def resource
      collection.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :category_id, :price, :status)
    end
end
