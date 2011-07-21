class HomeController < ApplicationController
  
  def index
    #puts "IP Addressof the computer"
    #puts request.env['REMOTE_ADDR']
    #cookies.delete :_thorai_returning_user
    #puts ENV["RAILS_ENV"]

    #if returning_user?
    @chest = current_chest
    if user_signed_in?
      @user = current_user
      unless (current_user.profile.nil? && current_user.profile.user_interests.empty?)
        @active_deals = Deal.still_active(DateTime.now).match_user_interests(@user)
      else
        @active_deals = Deal.still_active(DateTime.now)
      end
    else
      @active_deals = Deal.still_active(DateTime.now)
    end
    
    if !returning_user?
      cookies.permanent[:_thorai_returning_user] = "t"
      redirect_to subscriptions_new_url
    end
    
  end
  
  def purchase
    @purchase_deal = Deal.find_by_id(params[:deal_id])
    
    if user_signed_in?
      @user = current_user
    else
      session[:_thorai_back_to_c_out] = true
      session[:_thorai_back_url] = request.url
    end
    params[:quantity] = 1;
    @total_price = params[:quantity] * @purchase_deal.deal_price;
  end
  
  def purchase_complete
    
    if user_signed_in?
      @user = current_user
      #AutoConfirmMailer.purchase_confirmation(@user).deliver
      puts "Deal ID"
      puts params[:deal_id]
      save_billing_info = params[:save_billing_info]
      if save_billing_info
        
      end
    else
    end
=begin      
      @user = User.new
      @profile = Profile.new
      @contact_info = ContactInformation.new
      @billing_address = Address.new
      
      @billing_address.street_address = params[:street_address]
      @billing_address.city = params[:city]
      @billing_address.state = params[:state]
      @billing_address.zip_code = params[:zip_code]
      @billing_address = 
      @billing_address.save
      
      @contact_info.address = @billing_address
      @contact_info.email = params[:user_email]
      
      @profile.contact_information = @contact_info

      @user.email = params[:user_email]
      @user.password = params[:password]
      @user.password_confirmation = params[:confirm]
      @user.enabled = true

      @profile.first_name = params[:first_name]
      @profile.last_name = params[:last_name]
      @profile.user_id = @user.id

      @card_holder_name = params[:card_holder_name]
      @card_number = params[:card_number]
      @security_code = params[:security_code]
      @exp_month = params[:exp_month]
      @exp_year = params[:exp_year]
      
      @profile.save
      @user.profile = @profile

      if @user.save
        if user = User.authenticate(@user.user_name, @user.password)
          session[:user_id] = user.id
            # redirect_to session_user_url
        end
          # else
         # render :action => 'new'
      end
    end
=end
  end

end