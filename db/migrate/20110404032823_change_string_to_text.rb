class ChangeStringToText < ActiveRecord::Migration
  def self.up
    change_column :deals, :description, :text
  end

  def self.down
  end
end
