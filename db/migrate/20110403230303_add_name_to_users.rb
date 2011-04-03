class AddNameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :invitation_id, :integer
    add_column :users, :invitation_fund, :float
  end

  def self.down
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :invitation_id
    remove_column :users, :invitation_fund
  end
end
