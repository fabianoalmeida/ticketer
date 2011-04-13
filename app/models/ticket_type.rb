class TicketType < ActiveRecord::Base

  #String :value
  #String :acronym
  #String :user
  #Integer :status

  belongs_to :status
  has_many :tickets

  validates :value, :acronym, :user, :status, :presence => { :message => "is required!" }

  validates :value, 
    :length => { :minimum => 1, :maximum => 80 },
    :uniqueness => { :message => "already exists!" },
    :if => lambda{ ! self.value.blank? }

  validates :acronym, 
    :length => { :minimum => 1, :maximum => 1 },
    :uniqueness => { :message => "already exists!" },
    :if => lambda{ ! self.acronym.blank? }

  accepts_nested_attributes_for :tickets

end
