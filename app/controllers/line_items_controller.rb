class LineItemsController < ApplicationController
  
  before_filter :authenticate_admin!, :only => :index
  
  def index
    @line_items = LineItem.all
  end

  def show
    @line_item = LineItem.find(params[:id])
  end

  def new
    @line_item = LineItem.new
  end

  def create
    @chest = current_chest
    deal = Deal.find(params[:line_item][:deal_id])
    @line_item = @chest.add_deal(deal.id)
    if @line_item.save
      respond_to do |format|
        #format.html { redirect_to(home_index_url) }
        format.js #{ @current_item = @line_item }
      end
    else
      format.html { render :action => "new" }
    end
  end

  def edit
    @line_item = LineItem.find(params[:id])
  end

  def update
    @line_item = LineItem.find(params[:id])
    if @line_item.update_attributes(params[:line_item])
      flash[:notice] = "Successfully updated line item."
      redirect_to @line_item
    else
      render :action => 'edit'
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    flash[:notice] = "Successfully destroyed line item."
    redirect_to home_index_url
  end
end
