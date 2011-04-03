class DailyDealMailing < ActiveRecord::Base

  attr_accessible :city_id, :email, :scheduled_at, :delivered_at
  has_one :profile, :dependent => :destroy
  belongs_to :city
  validates :email, :presence => true
  
  scope :for_today, lambda{ |current_time|{
                                                  :conditions => [
                                                                    "scheduled_at.day == ?.day and scheduled_at.hour - ?.hour == 2", 
                                                                    current_time, 
                                                                    current_time
                                                                  ],
                                                  :order => user_email
                                                }
                                  }

  def self.next_for_delivery
    puts "Checking database..."
    DailyDealMailing.first(:conditions => ["delivered_at IS NULL"], :order => "email")
  end
  
  def deliver
    
    #update_attribute(:scheduled_at, nil)
    sleep 1 # placeholder for sending email
    #update_attribute(:delivered_at, Time.now)
    puts "Mail Delivered"
  end
  
=begin
  def self.get_time_zone_map
    time_zones = { 
                    "AL" => "Central Time (US & Canada)",
                    "AK" => "Alaska",
                    "AZ" => "Mountain Time (US & Canada)",
                    "AR" => "Central Time (US & Canada)",
                    "CA" => "Pacific Time (US & Canada)",
                    "CO" => "Mountain Time (US & Canada)",
                    "CT" => "Eastern Time (US & Canada)",
                    "DE" => "Eastern Time (US & Canada)",
                    "FL" => "Eastern Time (US & Canada)",
                    "GA" => "Eastern Time (US & Canada)",
                    "HI" => "Hawaii",
                    "ID" => "Mountain Time (US & Canada)",
                    "IL" => "Central Time (US & Canada)",
                    "IN" => "Eastern Time (US & Canada)",
                    "IA" => "Central Time (US & Canada)",
                    "KS" => "Central Time (US & Canada)",
                    "KY" => "Central Time (US & Canada)",
                    "LA" => "Central Time (US & Canada)",
                    "ME" => "Eastern Time (US & Canada)",
                    "MD" => "Eastern Time (US & Canada)",
                    "MA" => "Eastern Time (US & Canada)",
                    "MI" => "Eastern Time (US & Canada)",
                    "MN" => "Central Time (US & Canada)",
                    "MS" => "Central Time (US & Canada)",
                    "MO" => "Central Time (US & Canada)",
                    "MT" => "Mountain Time (US & Canada)",
                    "NE" => "Central Time (US & Canada)",
                    "NV" => "Pacific Time (US & Canada)",
                    "NH" => "Eastern Time (US & Canada)",
                    "NJ" => "Eastern Time (US & Canada)",
                    "NM" => "Mountain Time (US & Canada)",
                    "NY" => "Eastern Time (US & Canada)",
                    "NC" => "Eastern Time (US & Canada)",
                    "ND" => "Central Time (US & Canada)",
                    "OH" => "Eastern Time (US & Canada)",
                    "OK" => "Central Time (US & Canada)",
                    "OR" => "Pacific Time (US & Canada)",
                    "PA" => "Eastern Time (US & Canada)",
                    "RI" => "Eastern Time (US & Canada)",
                    "SC" => "Eastern Time (US & Canada)",
                    "SD" => "Central Time (US & Canada)",
                    "TN" => "Central Time (US & Canada)",
                    "TX" => "Central Time (US & Canada)",
                    "UT" => "Mountain Time (US & Canada)",
                    "VT" => "Eastern Time (US & Canada)",
                    "VA" => "Eastern Time (US & Canada)",
                    "WA" => "Pacific Time (US & Canada)",
                    "WV" => "Eastern Time (US & Canada)",
                    "WI" => "Central Time (US & Canada)",
                    "WY" => "Mountain Time (US & Canada)"
                  }.freeze
    time_zones
  end
=end
  
end
