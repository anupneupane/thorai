class OrdersController < ApplicationController
  
  #before_filter :authenticate_user!, :only => [:create]
  
  def index
    @orders = Order.find_all_by_user_id(current_user.id)
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    if current_chest.line_items.empty?
      redirect_to home_index_url, :notice => "Your chest is empty"
      return
    end
    
    if !user_signed_in?
      session[:_purchest_no_session_at_checkout] = true
      session[:_purchest_orders_url] = request.url
    end
    
    @order = Order.new
    @cur_chest = current_chest
  end

  def create
    @order = Order.new(params[:order])
    @order.add_line_items_from_chest(current_chest)
    @order.ip_address = request.remote_ip

    unless user_signed_in?
      @user = User.make_user(params[:user_email], params[:first_name], params[:last_name], params[:password], params[:confirm])
      if @user.save
        sign_in(@user)
        @profile = Profile.make_profile(params[:user_email], params[:first_name], params[:last_name])
        @profile.user_id = @user.id
        if @profile.save
          @contact_information = @profile.build_contact_information
          @contact_information.profile_id = @profile.id
          if @contact_information.save
            @address = @contact_information.build_address
            @address.contact_information_id = @contact_information.id
            @address.save
          end
        end
      end
    end
    
    if user_signed_in?
      @order.user_id = current_user.id
      if use_invitation_fund?
        if current_chest.total_price >= current_user.invitation_fund
          
        else
          
        end
      else
        
      end
    end
    
    if @order.save
      if @order.purchase
        puts "Purchase successful"
      end
      Chest.destroy(session[:chest_id])
      session.delete :chest_id
      flash[:notice] = "Successfully created order."
      redirect_to @order
    else
      render :action => 'new'
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(params[:order])
      flash[:notice] = "Successfully updated order."
      redirect_to @order
    else
      render :action => 'edit'
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    flash[:notice] = "Successfully destroyed order."
    redirect_to orders_url
  end    
  
end
