class Order < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 100  
  
  attr_accessible :user_id
  belongs_to :user
  has_many :line_items, :dependent => :destroy
  
  def add_line_items_from_chest(chest)
    chest.line_items.each do |item|
      item.chest_id = nil
      line_items << item
    end
  end
  
end
