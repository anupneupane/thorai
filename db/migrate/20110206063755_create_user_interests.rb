class CreateUserInterests < ActiveRecord::Migration
  def self.up
    create_table :user_interests do |t|
      t.integer :profile_id
      t.integer :sub_category_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :user_interests
  end
end
