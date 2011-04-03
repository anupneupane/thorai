class RemoveInvitationLimit < ActiveRecord::Migration
  def self.up
    remove_column :users, :invitation_limit
  end

  def self.down
  end
end
