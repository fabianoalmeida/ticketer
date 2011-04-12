class Status < ActiveRecord::Base

  #String :value
  #String :user

  validates :value, :user, :presence => { :message => "is required!" }

  validates :value, 
    :length => { :minimum => 1, :maximum => 80 }, 
    :uniqueness => { :message => "already exists!", :case_sensitive => false },
    :unless => lambda{ self.value.blank? }

  def self.active
    self.where( :value => "Active" ).first
  end

  def self.inactive
    self.where( :value => "Inactive" ).first
  end
  
end
