class ProfilesController < ApplicationController

  before_filter :authenticate_admin!, :only => [:index, :show, :destroy]

  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def new

    UserMailer.registration_confirmation(current_user).deliver
    
    @profile = Profile.new
    
    contact_information = @profile.build_contact_information
    @profile.contact_information.email = current_user.email

    address = contact_information.build_address
    @categories = Category.find(:all, :order=>"name ASC")
    puts "Categories"
    @categories.each do |cat|
      @subs = cat.sub_categories
      @subs.each do |sb|
        puts sb.id
      end
    end
    #@sub_categories = SubCategory.find(:all, :order=>"name ASC")
    @profile.user_interests.build
    
  end

  def create
    @profile = Profile.new(params[:profile])
    @profile.user_id = current_user.id
    @profile.first_name = current_user.first_name
    @profile.last_name = current_user.last_name
    @profile.contact_information.email = current_user.email
    checked_user_interests = params[:profile][:user_interest_ids]
    if @profile.save
      if !checked_user_interests.nil?
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
      redirect_to home_index_path
    else
      render :action => 'new'
    end
  end

  def edit
    @profile = Profile.find(params[:id])
    @categories = Category.all
  end

  def update
    @profile = Profile.find(params[:id])
    checked_user_interests = params[:profile][:user_interest_ids]
    if @profile.update_attributes(params[:profile])
      UserInterest.destroy_all(["profile_id = ?", @profile.id])
      if !checked_user_interests.nil?
        checked_user_interests.each{
          |checked_item|
          @user_interest = UserInterest.new
          @user_interest.profile_id = @profile.id
          @user_interest.sub_category_id = checked_item
          @user_interest.name = SubCategory.find(checked_item).name
          @user_interest.save
        }
      end
      flash[:notice] = "Successfully updated profile."
      redirect_to users_show_user_account_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy
    flash[:notice] = "Successfully destroyed profile."
    redirect_to profiles_url
  end
end
