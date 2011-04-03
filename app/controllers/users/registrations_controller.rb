class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_user!, :except => [:new, :create]

  def new
    @user = User.new(:invitation_token => params[:invitation_token])
    if @user.invitation
      @user.email = @user.invitation.recipient_email 
      session[:_purchest_invitation_token] = params[:invitation_token]
      session[:_purchest_recipient_email] = @user.invitation.recipient_email
    end
  end

  def create
    session["#{resource_name}_return_to"] = new_profile_path
    
    if invited_user_already_signed_up?
      delete_session_invitation
    end
    
    # calling superclass implementation
    super
    
    # update newly created user's invitation_fund to 0
    if user_signed_in?
      current_user.update_attribute(:invitation_fund, 0.0);
    end

    if invitation_token_present?
      @invitation_to_activate = Invitation.find_by_token(current_user.invitation.token) 
      @invitation_to_activate.update_attribute(:activated, true)
      
      #update sender's invitation fund
      @sender = User.find(@invitation_to_activate.sender_id)
      invitation_fund = @sender.invitation_fund
      invitation_fund += 10 # Todo: Replace with a constant variable here
      
      @sender.update_attribute(:invitation_fund, invitation_fund)
      delete_session_invitation
     end
  end
  
  def edit
    super
  end
  
  def edit_user_info
  end
  
  def show_user_account
  end
  
  def update
    super
  end
  
  def destory
    super
  end

end