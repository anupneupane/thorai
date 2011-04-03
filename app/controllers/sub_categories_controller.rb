class SubCategoriesController < ApplicationController
  
  before_filter :authenticate_admin!
  
  def index
    @sub_categories = SubCategory.all
  end

  def show
    @sub_category = SubCategory.find(params[:id])
  end

  def new
    puts "Creating New Category"
    @category = Category.find(params[:category_id])
    @sub_category = @category.sub_categories.build
  end

  def create
    @category = Category.find(params[:category_id])
    @sub_category = @category.sub_categories.build(params[:sub_category])
    if @sub_category.save
      flash[:notice] = "Successfully created sub category."
      redirect_to @category
    else
      render :action => 'new'
    end
  end

  def edit
    @sub_category = SubCategory.find(params[:id])
  end

  def update
    @sub_category = SubCategory.find(params[:id])
    if @sub_category.update_attributes(params[:sub_category])
      flash[:notice] = "Successfully updated sub category."
      redirect_to @sub_category
    else
      render :action => 'edit'
    end
  end

  def destroy
    @sub_category = SubCategory.find(params[:id])
    @sub_category.destroy
    flash[:notice] = "Successfully destroyed sub category."
    redirect_to sub_categories_url
  end
end
