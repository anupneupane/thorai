class SubscriptionsController < ApplicationController
  def new
    @profile = Profile.new
    @categories = Category.ordered
    @sub_categories = SubCategory.ordered
    @profile.user_interests.build
  end

  def create
    @daily_deal_mailing = DailyDealMailing.new
    @daily_deal_mailing.email = params[:email]
    
    if @daily_deal_mailing.save
      @profile = Profile.new
      @profile.daily_deal_mailing_id = @daily_deal_mailing.id
      if @profile.save
        if params[:user_interest_ids]
          checked_user_interests = params[:profile][:user_interest_ids]
          checked_user_interests.each {
            |checked_item|
            @user_interest = UserInterest.new
            @user_interest.profile_id = @profile.id
            @user_interest.sub_category_id = checked_item
            @user_interest.name = SubCategory.find(checked_item).name
            @user_interest.save
          }
        end
        flash[:notice] = "Successfully created profile."
        redirect_to home_index_url
      else
        render :action => 'new'
      end
    end
  end

end