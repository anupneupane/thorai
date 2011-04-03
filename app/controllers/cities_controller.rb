class CitiesController < ApplicationController
  
  before_filter :authenticate_admin!
  
  def index
    @user = current_user
    @cities = City.all
  end

  def show
    @user = current_user
    @city = City.find(params[:id])
  end

  def new
    @user = current_user
    @city = City.new
  end

  def create
    @user = current_user
    @city = City.new(params[:city])
    @city.state = params[:state][:id]
    puts "State"
    puts params[:state]
    if @city.save
      flash[:notice] = "Successfully created city."
      redirect_to @city
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
    @city = City.find(params[:id])
  end

  def update
    @user = current_user
    @city = City.find(params[:id])
    if @city.update_attributes(params[:city])
      flash[:notice] = "Successfully updated city."
      redirect_to @city
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = current_user
    @city = City.find(params[:id])
    @city.destroy
    flash[:notice] = "Successfully destroyed city."
    redirect_to cities_url
  end
end
