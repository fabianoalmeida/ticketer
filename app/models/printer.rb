class Printer < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name, use: :slugged

  attr_accessible :name
  
  has_many :totems

  validates :name, :presence => true
end
