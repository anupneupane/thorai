class CreateDeals < ActiveRecord::Migration
  def self.up
    create_table :deals do |t|
      t.integer :merchant_id
      t.integer :sub_category_id
      t.string :title
      t.string :description
      t.float :original_price
      t.float :deal_price
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :is_on
      t.timestamps
    end
  end

  def self.down
    drop_table :deals
  end
end
