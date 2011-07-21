class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :delete_session_purchase
  before_filter :ensure_domain
  #include SslRequirement
  #before_filter :prepare_for_mobile

  #APP_DOMAIN = 'www.thorai.com'

  def ensure_domain
    #if request.env['HTTP_HOST'] != APP_DOMAIN
      # HTTP 301 is a "permanent" redirect
      #redirect_to "http://#{APP_DOMAIN}", :status => 301
    #end
  end
    
  protected
    def delete_session_purchase
      session.delete :_thorai_no_session_at_checkout
      session.delete :_thorai_orders_url
    end
    
    def delete_session_invitation
      session.delete :_thorai_recipient_email
      session.delete :_thorai_invitation_token
    end
    
    def delete_chest
      session.delete :chest_id      
    end
    
  private
  
    #def prepare_for_mobile
      #session[:mobile_param] = params[:mobile] if params[:mobile]
      #request.format = :mobile if mobile_device?
    #end
  
    def returning_user?
      if cookies[:_thorai_returning_user] == "t"
        true
      end
    end
    
    def current_chest
      begin
        Chest.find(session[:chest_id])
      rescue ActiveRecord::RecordNotFound
        chest = Chest.create
        session[:chest_id] = chest.id
        chest
      end
    end
    
    def current_order
      Order.find(session[:chest_id])
    end
    
    def invited_user_already_signed_up?
      if User.find_by_email(session[:_thorai_recipient_email])
        true
      end
    end
    
    def invitation_token_present?
      if session[:_thorai_invitation_token]
        true
      end
    end
    
    def save_payment_information?
      if params[:save_billing_info] == 1
        true
      end
    end

    def use_invitation_fund?
      if params[:use_invitation_fund] == 1
        true
      end
    end
    
    def clear_chest_for_new_session?
      if session[:_thorai_no_session_at_checkout].nil?
        true
      end
    end

end