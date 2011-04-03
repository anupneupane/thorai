class InvitationsController < ApplicationController
  
  before_filter :authenticate_user!
  
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user
    @invitation.amount = 10 # Todo: Change here later
    @invitation.activated = false
    if @invitation.save
      puts "Saving Invitation..."
      UserMailer.invitation(@invitation, new_user_registration_url + '/' + @invitation.token).deliver
      redirect_to home_index_url
    else
      render :action => 'new'
    end
  end
end
