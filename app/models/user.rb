class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :invitation_token, :remember_me
  validates_presence_of :first_name, :last_name, :email, :password, :password_confirmation

  has_one :profile, :dependent => :destroy
#  delegate :first_name, :last_name, :birth_date, :to => :profile
  
  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
  belongs_to :invitation
  
  has_many :orders, :dependent => :destroy
  
  has_many :discussions, :dependent => :destroy
#  delegate :comment, :to => :discussion
  
  def self.make_user(email, first_name, last_name, password, confirm)
    @user = User.new
    @user.email = email
    @user.first_name = first_name
    @user.last_name = last_name
    @user.password = password
    @user.password_confirmation = confirm
    @user
  end
  
  def invitation_token
    invitation.token if invitation
  end
    
  def invitation_token=(token)
    self.invitation = Invitation.find_by_token(token)
  end
  
end
