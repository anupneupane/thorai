class City < ActiveRecord::Base
  attr_accessible :state, :city_name
  has_many :daily_deal_mailings, :dependent => :destroy

  validates_presence_of :city_name
  scope :ordered_by_name, order("city_name")
end
