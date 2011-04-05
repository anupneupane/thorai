class Address < ActiveRecord::Base
  attr_accessible :contact_information_id, :street_address, :city, :state, :zip_code
  belongs_to :contact_information
  
  #validates_presence_of :street_address, :city, :state, :zip_code
  
end