class AddActivatedToReferral < ActiveRecord::Migration
  def self.up
    add_column :referrals, :activated, :boolean
  end

  def self.down
    remove_column :referrals, :activated
  end
end
