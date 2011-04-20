class Local < ActiveRecord::Base

  #String :des_local

  has_many :place

  validates :des_local, :presence => true
  
end
