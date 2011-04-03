class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :sub_categories, :dependent => :destroy
  validates_presence_of :name
  
  scope :ordered, order("name")
end