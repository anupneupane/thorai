class CreateDiscussions < ActiveRecord::Migration
  def self.up
    create_table :discussions do |t|
      t.integer :user_id
      t.integer :deal_id
      t.string :comment
      t.timestamps
    end
  end

  def self.down
    drop_table :discussions
  end
end
