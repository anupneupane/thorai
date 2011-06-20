class Merchant < ActiveRecord::Base
  attr_accessible :sub_category_id, :name, :picture
  belongs_to :sub_category
  has_many :contact_informations, :dependent => :destroy
  has_many :deals, :dependent => :destroy
  accepts_nested_attributes_for :contact_informations
  
  validates_presence_of :name
  
  has_attached_file :picture, 
                    #:styles => { :medium => "300x300", :thumb => "100x100"},
                    :storage => :s3,
                    :s3_credentials => {
                        :access_key_id => ENV['S3_KEY'],
                        :secret_access_key => ENV['S3_SECRET']
                    },
                    :bucket => ENV['S3_BUCKET'],
                    :path => ":attachment/:id"
  
end