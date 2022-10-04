class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new categories_params
    if @category.save
      redirect_to categories_path
    else
      render :new
    end
  end

  def edit
    @category = Category.find_by id: params[:id]
    # id: - name of column in db, params - об'єкт зі всіма параметрами запиту,
    # :id - параметр запиту
  end

  def update
    @category = Category.find_by id: params[:id]
    if @category.update categories_params
      redirect_to categories_path
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find_by id: params[:id]
    @category.destroy
    redirect_to categories_path
  end

  def show
    @category = Category.find_by id: params[:id]
  end

  private

  def categories_params
    params.require(:category).permit(:name)
  end
end
