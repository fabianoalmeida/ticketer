class StatusTicket < ActiveRecord::Base

  #String :value
  #String :acronym
  #String :user

  validates :value, :acronym, :user, :presence => { :message => "it is necessary!" }

  validates :acronym, 
    :length => { :minimum => 1, :maximum => 1 }, 
    :uniqueness => { :message => "already exists!" },
    :if => lambda{ ! self.acronym.blank? }

  validates :value, 
    :length => { :minimum => 1, :maximum => 80 }, 
    :uniqueness => { :message => "already exists!" },
    :if => lambda{ ! self.value.blank? }

end
