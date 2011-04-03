class UserMailer < ActionMailer::Base

    def registration_confirmation(user)
      @user = user
      mail( :to => user.email,
            :subject => "Registration Confirmation",
            :from => "purchest@gmail.com"
          )
    end

    def purchase_confirmation(user)
      @user = user
      mail( :to => "#{user.profile.first_name} #{user.profile.last_name} <#{user.profile.contact_information.email}>",
            :subject => "Purchase Confirmation",
            :from => "purchest@gmail.com"
          )
    end

    def daily_deal_mail(daily_deal_mailing_list, deal)
      mail( :to => daily_deal_mailing_list.user_email,
            :subject => deal.title,
            :from => "purchest@gmail.com"
          )
    end
    
    def invitation(invitation, signup_url)
      @invitation = invitation
      @sender = @invitation.sender
      @signup_url = signup_url
      mail( :to => invitation.recipient_email,
            :subject => "#{@sender.profile.first_name} #{@sender.profile.last_name} invites you to purchest",
            :from => "purchest@gmail.com"
          )
      invitation.update_attribute(:sent_at, Time.now)
    end
  
end
