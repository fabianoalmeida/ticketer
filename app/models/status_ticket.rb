class StatusTicket < ActiveRecord::Base

  #String :value
  #String :acronym
  #String :user

  has_many :tickets

  validates :value, :acronym, :user, :presence => { :message => "is required!" }

  validates :acronym, 
    :length => { :minimum => 1, :maximum => 1 }, 
    :uniqueness => { :message => "already exists!" },
    :unless => lambda{ self.acronym.blank? }

  validates :value, 
    :length => { :minimum => 1, :maximum => 80 }, 
    :uniqueness => { :message => "already exists!" },
    :unless => lambda{ self.value.blank? }

  accepts_nested_attributes_for :tickets

  def self.called
    self.where( :acronym => "C" ).first
  end

  def self.closed
    self.where( :acronym => "L" ).first
  end

end
