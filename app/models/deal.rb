class Deal < ActiveRecord::Base
  attr_accessible :merchant_id, :sub_category_id, :title, :description, :original_price, :deal_price, :start_date, :end_date, :is_on
  
  attr_reader :dollars_saved, :discount_percent
  
  has_many :line_items
  belongs_to :merchant
  belongs_to :sub_category
  has_many :discussions, :dependent => :destroy
  
  before_destroy :ensure_not_referenced_by_any_line_item
  
  validates_presence_of :title, :original_price, :deal_price, :start_date, :end_date
  
  scope :still_active, lambda{ |current_time|{:conditions => ["start_date < ? and end_date > ?", current_time, current_time]}}

  def Deal.match_user_interests(user)                                             
    deals = Deal.find_by_sql(["select * from deals d " +
                              "where d.sub_category_id IN " + 
                              "(select DISTINCT sub_category_id " +
                              "from user_interests where user_interests.profile_id = ?)", user.profile.id])
  end

  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end
  
  def dollars_saved
    self.original_price - self.deal_price
  end
  
  def discount_percent
    (dollars_saved * 100 / self.original_price).round
  end

end
