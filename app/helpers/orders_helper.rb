module OrdersHelper
  
  def invitation_funds_usable?
    if user_signed_in?
      if !current_user.invitation_fund.nil? && current_user.invitation_fund > 0
          true
      end
    end
  end
  
end
