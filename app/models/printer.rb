class Printer < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name, use: :slugged

  attr_accessible :name, :template
  
  has_many :totems

  validates :name, :template, :presence => true
end
