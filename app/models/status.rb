class Status < ActiveRecord::Base

  #String :value
  #String :user

  validates :value, :user, :presence => true 

  validates :value, 
    :length => { :in => 1..80 }, 
    :uniqueness => { :case_sensitive => false },
    :allow_blank => false

  def self.active
    self.where( :value => "Active" ).first
  end

  def self.inactive
    self.where( :value => "Inactive" ).first
  end
  
end
