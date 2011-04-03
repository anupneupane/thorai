class AddMerchantIdToContactInformation < ActiveRecord::Migration
  def self.up
    add_column :contact_informations, :merchant_id, :integer
  end

  def self.down
    remove_column :contact_informations, :merchant_id
  end
end
