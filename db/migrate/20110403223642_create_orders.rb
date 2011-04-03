class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :discussions do |t|
      t.integer :user_id
      t.integer :card_payment_id
      t.timestamps
    end
  end

  def self.down
    drop_table :discussions
  end
end
