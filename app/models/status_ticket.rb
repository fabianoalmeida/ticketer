class StatusTicket < ActiveRecord::Base

  #String :value
  #String :acronym
  #String :user

  has_many :tickets

  validates :value, :acronym, :user, :presence => { :message => "is required!" }

  validates :acronym, 
    :length => { :is => 1 }, 
    :uniqueness => { :message => "already exists!", :case_sensitive => false },
    :allow_blank => false

  validates :value, 
    :length => { :in => 1..80 }, 
    :uniqueness => { :message => "already exists!", :case_sensitive => false },
    :allow_blank => false

  def self.called
    self.where( :acronym => "C" ).first
  end

  def self.closed
    self.where( :acronym => "L" ).first
  end

end
