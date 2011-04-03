class MerchantsController < ApplicationController

  before_filter :authenticate_admin!

  def index
    @user = current_user
    @merchants = Merchant.all
  end

  def show
    @user = current_user
    @merchant = Merchant.find(params[:id])
    @sub_category = SubCategory.find_by_id(@merchant.sub_category_id)
    @category = Category.find_by_id(@sub_category.category_id)
  end

  def new
    @user = current_user
    @merchant = Merchant.new
    @sub_categories = SubCategory.find(:all, :order=>"name ASC")
    contact_information = @merchant.contact_informations.build
    contact_information.build_address
  end

  def create
    @user = current_user
    @merchant = Merchant.new(params[:merchant])
    @sub_categories = SubCategory.find(:all, :order=>"name ASC")
    if @merchant.save
      flash[:notice] = "Successfully created merchant."
      redirect_to @merchant
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
    @merchant = Merchant.find(params[:id])
    @sub_categories = SubCategory.find(:all, :order=>"name ASC")
    @sub_category = @merchant.sub_category
  end

  def update
    @user = current_user
    @merchant = Merchant.find(params[:id])
    @sub_categories = SubCategory.find(:all, :order=>"name ASC")
    
    if @merchant.update_attributes(params[:merchant])
      flash[:notice] = "Successfully updated merchant."
      redirect_to @merchant
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = current_user
    @merchant = Merchant.find(params[:id])
    @merchant.destroy
    flash[:notice] = "Successfully destroyed merchant."
    redirect_to merchants_url
  end
end
