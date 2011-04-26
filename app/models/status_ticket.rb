class StatusTicket < ActiveRecord::Base

  #String :value
  #String :acronym
  #String :user

  has_many :tickets

  validates :value, :acronym, :user, :presence => true

  validates :acronym, 
    :length => { :maximum => 3 }, 
    :uniqueness => { :case_sensitive => false },
    :allow_blank => false

  validates :value, 
    :length => { :in => 1..80 }, 
    :uniqueness => { :case_sensitive => false },
    :allow_blank => false

  def self.available
    self.where( :value => "Available" ).first
  end

  def self.called
    self.where( :value => "Called" ).first
  end

  def self.pending
    self.where( :value => "Pending" ).first
  end

  def self.canceled
    self.where( :value => "Canceled" ).first
  end

  def self.attended
    self.where( :value => "Attended" ).first
  end

  def self.id_for(state_string)
    self.where("lower(value) = ?", state_string.downcase).first
  end
end
