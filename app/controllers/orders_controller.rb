class OrdersController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:create]
  
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
    @order.processed = false
    
    if user_signed_in?
      @order.user_id = current_user.id
      if use_invitation_fund?
        if current_chest.total_price >= current_user.invitation_fund
          
        else
          
        end
      end
      
      # Todo: condition that says pay using existing credit card
      if true 

      else
        @card_info = CardPayment.new
        @card_info.cardholder_name = params[:card_holder_name]
        @card_info.card_number = params[:card_number]
        @card_info.exp_month = params[:exp_month]
        @card_info.exp_year = params[:exp_year]
        @card_info.security_code = params[:security_code]

        if sav[e_payment_information?
          @card_info.save
          @order.card_payment_id = @card_info.id
        end
        # Todo: Process payment here
      end
    else
      # create a new user
      @user = User.new
      @user.email = params[:user_email]
      @user.first_name = params[:first_name]
      @user.last_name = params[:last_name]
      @user.password = params[:password]
      @user.password_confirmation = params[:confirm]
      if @user.save
        @order.user_id = @user.id
        sign_in(@user)
        
        @profile = Profile.new
        @contact_information = @profile.build_contact_information
        @profile.contact_information.email = current_user.email

        @address = @contact_information.build_address
        
        @profile.user_id = current_user.id
        @profile.first_name = current_user.first_name
        @profile.last_name = current_user.last_name

        if @profile.save
          flash[:notice] = "Successfully created profile."
          @contact_information.profile_id = @profile.id
          if @contact_information.save
            @address.contact_information_id = @contact_information.id
            @address.save
          end
        end
      end
    end
    
    if @order.save
      Chest.destroy(session[:chest_id])
      session[:chest_id] = nil
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
  
  private
    
  
end
