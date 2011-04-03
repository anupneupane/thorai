class AddDailyEmailToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :daily_deal_mailing_id, :integer
  end

  def self.down
    remove_column :profiles, :daily_deal_mailing_id
  end
end
