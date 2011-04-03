class CreateUserDeals < ActiveRecord::Migration
  def self.up
    create_table :user_deals do |t|
      t.integer :user_id
      t.integer :deal_id
      t.integer :quantity
      t.float :total_price

      t.timestamps
    end
  end

  def self.down
    drop_table :user_deals
  end
end
