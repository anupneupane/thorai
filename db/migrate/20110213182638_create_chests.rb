class CreateChests < ActiveRecord::Migration
  def self.up
    create_table :chests do |t|
      t.timestamps
    end
  end

  def self.down
    drop_table :chests
  end

end
