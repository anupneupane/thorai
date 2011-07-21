class Users::SessionsController < Devise::SessionsController
  skip_before_filter :delete_session_purchase, :only => [:new, :create]
  #before_filter :delete_chest, :only => :create

  def new
    super
  end

  def create
    if clear_chest_for_new_session?
      delete_chest
    end
    
    if session[:_thorai_no_session_at_checkout] == true
      session["#{resource_name}_return_to"] = session[:_thorai_orders_url]
      delete_session_purchase
    end
    
    if current_user.profile.nil?
        @profile = Profile.new
        @profile.user_id = current_user.id
        @profile.first_name = current_user.first_name
        @profile.last_name = current_user.last_name
        if @profile.save
          flash[:notice] = "Successfully created profile."
          @contact_information = ContactInformation.new
          @address = Address.new
          @contact_information.profile_id = @profile.id
          if @contact_information.save(false)
            @address.contact_information_id = @contact_information.id
            @address.save(false)
          end
        end
      end

    super 
  end
  
  def destroy
    if !session[:chest_id].nil?
      Chest.destroy(session[:chest_id])
      session[:chest_id] = nil
    end
    delete_session_purchase
    super
  end

end