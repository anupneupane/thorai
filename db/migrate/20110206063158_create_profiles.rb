class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.date :birth_date
      t.integer :daily_deal_mailing_id
      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
