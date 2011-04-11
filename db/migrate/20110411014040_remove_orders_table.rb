class RemoveOrdersTable < ActiveRecord::Migration
  def self.up
    drop_table :orders
  end

  def self.down
  end
end
