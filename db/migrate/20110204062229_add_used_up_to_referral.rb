class AddUsedUpToReferral < ActiveRecord::Migration
  def self.up
    add_column :referrals, :used_up, :boolean
  end

  def self.down
    remove_column :referrals, :used_up
  end
end
