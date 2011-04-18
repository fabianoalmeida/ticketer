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
    :uniqueness => { :message => "already exists!", :case_sensitive => false },
    :allow_blank => false

  validates :acronym, 
    :length => { :maximum => 3 },
    :uniqueness => { :message => "already exists!", :case_sensitive => false },
    :allow_blank => false

end
