class MakeChangesToOrder < ActiveRecord::Migration
  def self.up
      add_column :orders, :ip_address, :string
      add_column :orders, :card_type, :string
      add_column :orders, :card_expires_on, :date
      remove_column :orders, :card_payment_id
      remove_column :orders, :state
  end

  def self.down
    
  end
end