class StatusTicket < ActiveRecord::Base

  #String :value
  #String :acronym
  #Integer :user_id

  validates :value, :acronym, :user_id, :presence => { :message => "it is necessary!" }

  validates :acronym, :length => { :minimum => 1, :maximum => 1 }

  validates :value, :length => { :minimum => 1, :maximum => 80 }

end
