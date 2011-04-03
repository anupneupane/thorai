class LineItem < ActiveRecord::Base
  attr_accessible :deal_id, :chest_id, :order_id, :quantity
  STATES = %w(placed in_progress shipped returned cancelled)

  belongs_to :deal
  belongs_to :chest
  belongs_to :order
=begin  
  STATES.each do |state|
    define_method "#{state}?" do
      self.state == state
    end
  end
  
  class << self
    STATES.each do |state| do
      define_method "#{state}" do
        state
      end
    end
  end
=end
  def total_price
    deal.deal_price * quantity
  end
  
end