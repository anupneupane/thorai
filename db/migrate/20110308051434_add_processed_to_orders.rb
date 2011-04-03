class AddProcessedToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :processed, :boolean
  end

  def self.down
    remove_column :orders, :processed
  end
end
