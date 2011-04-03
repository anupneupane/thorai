class DealsController < ApplicationController
  
  before_filter :authenticate_admin!, :except => [:show]

  def index
    @user = current_user
    @deals = Deal.all
  end

  def show
    @user = current_user
    @chest = current_chest
    @deal = Deal.find(params[:id])
  end

  def new
    @user = current_user
    @deal = Deal.new
    @merchants = Merchant.find(:all, :order=>"name ASC")
  end

  def create
    @user = current_user
    @merchants = Merchant.find(:all, :order=>"name ASC")
    @deal = Deal.new(params[:deal])
    @deal.sub_category = @deal.merchant.sub_category
    if params[:deal_preview_before_create] == "true" || !@deal.save
      render :action => 'new'
    else
      if @deal.save
        flash[:notice] = "Successfully created deal."
        redirect_to @deal
      else
        render :action => 'new'
      end
    end

  end

  def edit
    @user = current_user
    @deal = Deal.find(params[:id])
    @merchants = Merchant.find(:all, :order=>"name ASC")
  end

  def update
    @user = current_user
    @deal = Deal.find(params[:id])
    if @deal.update_attributes(params[:deal])
      flash[:notice] = "Successfully updated deal."
      redirect_to @deal
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = current_user
    @deal = Deal.find(params[:id])
    @deal.destroy
    flash[:notice] = "Successfully destroyed deal."
    redirect_to deals_url
  end
    
end
