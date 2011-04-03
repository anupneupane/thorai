class PurchestOrdersController < ApplicationController

  def index
    @placed_orders = Order.paginate :page => params[:page], :order => 'created_at DESC'
  end

end
