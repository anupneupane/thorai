class UserDeals < ActiveRecord::Base
  belongs_to :User
  belongs_to :Deal
end
