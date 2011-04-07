class TicketType < ActiveRecord::Base

  #String :value
  #String :acronym
  #String :user
  #Integer :status_id

  validates :value, :acronym, :user, :status_id, :presence => { :message => "is required!" }

  validates :value, 
    :length => { :minimum => 1, :maximum => 80 },
    :uniqueness => { :message => "already exists!" },
    :if => lambda{ ! self.value.blank? }

  validates :acronym, 
    :length => { :minimum => 1, :maximum => 1 },
    :uniqueness => { :message => "already exists!" },
    :if => lambda{ ! self.acronym.blank? }

  has_one :status
  belongs_to :ticket

end
