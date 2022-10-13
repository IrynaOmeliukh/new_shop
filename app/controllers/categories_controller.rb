class CategoriesController < ApplicationController
  def index
    @categories = collection
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(categories_params)
    if @category.save
      redirect_to categories_path, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def edit
    @category = resource
  end

  def update
    @category = resource

    if @category.update categories_params
      redirect_to categories_path, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @category = resource
    @products = Product.where(category_id: @category.id)
    @products.each do |product|
      product.destroy
    end

    @category.destroy
    redirect_to categories_path, notice: 'Category was successfully destroyed.'
  end

  def show
    @category = resource
  end

  private

  def collection
    Category.all
  end

  def resource
    collection.find(params[:id])
  end

  def categories_params
    params.require(:category).permit(:name)
  end
end
