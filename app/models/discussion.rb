class Discussion < ActiveRecord::Base
  attr_accessible :user_id, :deal_id, :comment
  belongs_to :deal
  belongs_to :user
end
