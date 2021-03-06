class CategoriesController < ApplicationController
  
  before_action :authenticate_user!

  def index
    @category = Category.all

    render :json => @category
  end

  def show
    @category = Category.find(params[:id])

     render :json => @category
  end

  def create
    @category = Category.new(category_params)

    @response = { status: @category.save }

    render :json => @response
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def update
  end

  def destory
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end

end
