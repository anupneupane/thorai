class SubCategory < ActiveRecord::Base
  attr_accessible :sub_category_id, :name
  has_many :merchants
  has_many :deals
  belongs_to :category
  
  validates_presence_of :name
  scope :ordered, order("name")
  
end
