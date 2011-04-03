class Profile < ActiveRecord::Base
  attr_accessible :user_id, :first_name, :last_name, :birth_date, 
                  :contact_information_attributes, :user_interests_attributes
  belongs_to :user
  belongs_to :daily_deal_mailing
  has_one :contact_information, :dependent => :destroy
  accepts_nested_attributes_for :contact_information

  has_many :user_interests, :dependent => :destroy  
  accepts_nested_attributes_for :user_interests, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
  
  def get_user_interests
    my_interests = UserInterest.find_all_by_profile_id(self.id)
    interest_sub_categories = Array.new
    my_interests.each do |i|
      interest_sub_categories << i.sub_category_id
    end
    interest_sub_categories
  end
  
end