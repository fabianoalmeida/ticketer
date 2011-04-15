class Place < ActiveRecord::Base

  #String :value
  #String :user
  #Integer :status
  #Integer :local

  belongs_to :status
  belongs_to :local
  has_many :wickets
  has_many :tickets
  has_many :panels
  has_many :totems

  validates :status, :local, :presence => { :message => "is required!" }

  accepts_nested_attributes_for :totems, :tickets, :wickets, :panels

end
