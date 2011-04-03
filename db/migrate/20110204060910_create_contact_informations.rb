class CreateContactInformations < ActiveRecord::Migration
  def self.up
    create_table :contact_informations do |t|
      t.integer :profile_id
      t.string :email
      t.string :phone

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_informations
  end
end
