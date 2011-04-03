class CategoriesController < ApplicationController
  
  before_filter :authenticate_admin!

  def index
    @user = current_user
    @categories = Category.all
  end

  def show
    @user = current_user
    @category = Category.find(params[:id])
    @sub_categories = @category.sub_categories
  end

  def new
    @user = current_user
    @category = Category.new
  end

  def create
    @user = current_user
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = "Successfully created category."
      redirect_to @category
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
    @category = Category.find(params[:id])
  end

  def update
    @user = current_user
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice] = "Successfully updated category."
      redirect_to @category
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = current_user
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = "Successfully destroyed category."
    redirect_to categories_url
  end
end
