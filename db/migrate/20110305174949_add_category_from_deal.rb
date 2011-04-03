class AddCategoryFromDeal < ActiveRecord::Migration
  def self.up
    add_column :deals, :sub_category_id, :integer
  end

  def self.down
  end
end
