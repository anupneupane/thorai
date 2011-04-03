class DailyDealMailingsController < ApplicationController

    before_filter :authenticate_user!

  def index
    @daily_deal_mailings = DailyDealMailing.all
  end

  def show
    @daily_deal_mailing = DailyDealMailing.find(params[:id])
  end

  def new
    @daily_deal_mailing = DailyDealMailing.new
    @cities =  City.ordered_by_name
  end

  def create
    @daily_deal_mailing = DailyDealMailing.new(params[:daily_deal_mailing])
    @daily_deal_mailing.city_id = params[:city][:id]
    @city = City.find(@daily_deal_mailing.city_id);
    state = @city.state
    sch_time = DateTime.now.next
    time_zone = DailyDealMailing.get_time_zone_map[state]
    mail_hour = 6;
    if time_zone == "Eastern Time (US & Canada)"
      mail_hour = 5
    elsif time_zone == "Central Time (US & Canada)"
      mail_hour = 6
    elsif time_zone == "Mountain Time (US & Canada)"
      mail_hour = 7
    elsif time_zone == "Pacific Time (US & Canada)"
      mail_hour = 8
   e else
      mail_hour = 9
    end
    
    sch_time = sch_time.change(:hour => mail_hour)
    sch_time = sch_time.change(:minute => 0)
    sch_time = sch_time.change(:second => 0)
    @daily_deal_mailing.scheduled_at = sch_time
    @daily_deal_mailing.delivered_at = nil
    
    puts "Hour"
    puts mail_hour
    puts @daily_deal_mailing.scheduled_at
    puts "Time"
    puts sch_time
    
    if @daily_deal_mailing.save
      puts "Scheduled At"
      puts @daily_deal_mailing.scheduled_at
      flash[:notice] = "Successfully created daily deal mailing."
      redirect_to @daily_deal_mailing
    else
      render :action => 'new'
    end
  end

  def edit
    @daily_deal_mailing = DailyDealMailing.find(params[:id])
  end

  def update
    @daily_deal_mailing = DailyDealMailing.find(params[:id])
    if @daily_deal_mailing.update_attributes(params[:daily_deal_mailing])
      flash[:notice] = "Successfully updated daily deal mailing."
      redirect_to @daily_deal_mailing
    else
      render :action => 'edit'
    end
  end

  def destroy
    @daily_deal_mailing = DailyDealMailing.find(params[:id])
    @daily_deal_mailing.destroy
    flash[:notice] = "Successfully destroyed daily deal mailing."
    redirect_to daily_deal_mailings_url
  end
end
