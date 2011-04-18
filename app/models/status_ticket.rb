class StatusTicket < ActiveRecord::Base

  #String :value
  #String :acronym
  #String :user

  has_many :tickets

  validates :value, :acronym, :user, :presence => { :message => "is required!" }

  validates :acronym, 
    :length => { :maximum => 3 }, 
    :uniqueness => { :message => "already exists!", :case_sensitive => false },
    :allow_blank => false

  validates :value, 
    :length => { :in => 1..80 }, 
    :uniqueness => { :message => "already exists!", :case_sensitive => false },
    :allow_blank => false

  def self.opened
    self.where( :value => "Opened" ).first
  end

  def self.closed
    self.where( :value => "Closed" ).first
  end

end
