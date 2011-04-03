class InvitationTab < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.string :token
      t.integer :sender_id
      t.string :recipient_email
      t.string :message
      t.float :amount
      t.datetime :sent_at
      t.boolean :activated
      t.timestamps
    end
  end

  def self.down
    drop_table :invitations
  end
end
