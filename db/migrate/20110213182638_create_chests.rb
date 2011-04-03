class CreateChests < ActiveRecord::Migration
  def self.up
    Chest.all.each do |chest|
      sums = chest.line_items.group(:deal_id).sum(:quantity)

      sums.each do |deal_id, quantity|
        if quantity > 1
          chest.line_items.where(:deal_id => deal_id).delete_all
          chest.line_items.create(:deal_id=>deal_id, :quantity=>quantity)
        end
      end
    end
  end

  def self.down
    LineItem.where("quantity>1").each do |lineitem|
      lineitem.quantity.times do
        LineItem.create :chest_id=>lineitem.chest_id, :deal_id=>lineitem.deal_id, :quantity=>1
      end
      lineitem.destroy
    end
  end

end
