class CreateDailyDealMailings < ActiveRecord::Migration
  def self.up
    create_table :daily_deal_mailings do |t|
      t.integer :city_id
      t.string :email
      t.datetime :scheduled_at
      t.datetime :delivered_at
      t.timestamps
    end
  end

  def self.down
    drop_table :daily_deal_mailings
  end
end
