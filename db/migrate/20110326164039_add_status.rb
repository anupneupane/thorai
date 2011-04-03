class AddStatus < ActiveRecord::Migration
  def self.up
    add_column :line_items, :status, :string
  end

  def self.down
    remove_column :status, :integer
  end
end
