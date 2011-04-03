class AddInvitationFundToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :invitation_fund, :float
  end

  def self.down
    remove_column :users, :invitation_fund
  end
end
