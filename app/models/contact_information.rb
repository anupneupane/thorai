class ContactInformation < ActiveRecord::Base
  attr_accessible :profile_id, :email, :phone, :address_attributes
  
  belongs_to :profile
  has_one :address, :dependent => :destroy
  accepts_nested_attributes_for :address
  
  belongs_to :merchant
end
