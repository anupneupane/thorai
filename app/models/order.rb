class Order < ActiveRecord::Base
  cattr_reader :per_page
  attr_accessor :card_first_name, :card_last_name, :card_number, :card_verification
  validate_on_create :validate_card
  @@per_page = 100  
  
  attr_accessible :user_id
  belongs_to :user
  has_many :line_items, :dependent => :destroy
  
  def purchase
      response = GATEWAY.purchase(price_in_cents, credit_card, purchase_options)
      transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response)
      cart.update_attribute(:purchased_at, Time.now) if response.success?
      response.success?
    end

  def price_in_cents
    (current_chest.total_price * 100).round
  end
  
  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors.add_to_base message
      end
    end
  end

  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :type               => card_type,
      :number             => card_number,
      :verification_value => card_verification,
      :month              => card_expires_on.month,
      :year               => card_expires_on.year,
      :first_name         => card_first_name,
      :last_name          => card_last_name
    )
  end
  
  def add_line_items_from_chest(chest)
    chest.line_items.each do |item|
      item.chest_id = nil
      line_items << item
    end
  end
  
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
  
  def number
    "#{Time.now.to_i}-#{rand(1_000_000)}"
  end
end
