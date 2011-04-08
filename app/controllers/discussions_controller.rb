class DiscussionsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index, :show]
  
  def index
    @discussions = Discussion.all
  end

  def show
    @discussion = Discussion.find(params[:id])
  end

  def new
    @discussion = Discussion.new
  end

  def create
    @discussion = Discussion.new
    @discussion.user = current_user
    @discussion.deal = Deal.find(params[:discussion][:deal_id])
    @discussion.comment = params[:discussion][:comment]
    if @discussion.save
      flash[:notice] = "Thank you for the discussion."
      respond_to do |format|
        format.html {redirect_to @discussion.deal}
        format.js
      end      
    end
  end

  def edit
    @discussion = Discussion.find(params[:id])
  end

  def update
    @discussion = Discussion.find(params[:id])
    if @discussion.update_attributes(params[:discussion])
      flash[:notice] = "Successfully updated discussion."
      redirect_to @discussion
    else
      render :action => 'edit'
    end
  end

  def destroy
    @discussion = Discussion.find(params[:id])
    @discussion.destroy
    flash[:notice] = "Successfully destroyed discussion."
    redirect_to discussions_url
  end
end
