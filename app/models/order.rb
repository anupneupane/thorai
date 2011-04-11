class Order < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 100  
  
  attr_accessible :user_id
  belongs_to :user
  has_many :line_items, :dependent => :destroy
  
  has_many  :transactions,
            :class_name => 'OrderTransaction',
            :dependent => :destroy
            
  acts_as_state_machine :initial => :pending
  state :pending
  state :authorized
  state :paid
  state :payment_declined
  
  event :payment_authorized do
    transitions :from => :pending,
                :to => :authorized
    transitions :from => :payment_declined,
                :to => :authorized
  end
  
  event :payment_captured do
    transitions :from => :authorized,
                :to => :paid
  end
  
  event :transaction_declined do
    transitions :from => :pending,
                :to => :payment_declined

    transitions :from => :payment_declined,
                :to => :payment_declined

    transitions :from => :authorized,
                :to => :authorized                
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
  
  def authorize_payment(credit_card, options = {})
    options[:order_id] = number
    
    transaction do
      authorization = OrderTransaction.authorize(amount, credit_card, options)
      transactions.push(authorization)
      
      if authorization.success?
        payment_authorized!
      else
        transaction_declined!
      end

      authorization
    end
  end
  
  def authorization_reference
    if authorization = transactions.find_by_action_and_success('authorization', true, :order => 'id ASC')
      authorization.reference
    end
  end
  
  def capture_payment(options = {})
    transaction do
      capture = OrderTransaction.capture(amount, authorization_reference, options)
      transactions.push(capture)
      if capture.success?
        payment_captured!
      else
        transaction_declined!
      end
      
      capture
    end
  end
  
  def number
    "#{Time.now.to_i}-#{rand(1_000_000)}"
  end
end
