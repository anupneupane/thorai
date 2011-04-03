class ChestsController < ApplicationController

  def index
    @chests = Chest.all
  end

  def show
    begin
      @chest = Chest.find(params[:id])  
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid Chest #{params[:id]}"
      redirect_to home_index_path, :notic => 'Invalid Chest'
    end
  end

  def new
    @chest = Chest.new
  end

  def create
    @chest = Chest.new(params[:chest])
    if @chest.save
      flash[:notice] = "Successfully created chest."
      redirect_to @chest
    else
      render :action => 'new'
    end
  end

  def edit
    @chest = Chest.find(params[:id])
  end

  def update
    @chest = Chest.find(params[:id])
    if @chest.update_attributes(params[:chest])
      flash[:notice] = "Successfully updated chest."
      redirect_to @chest
    else
      render :action => 'edit'
    end
  end

  def destroy
    @chest = Chest.find(params[:id])
    @chest.destroy
    session[:chest_id] = nil
    flash[:notice] = "Your chest is currently empty."
    redirect_to home_index_url
  end
end
