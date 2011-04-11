class CallHistoryType < ActiveRecord::Base

  #String :value
  #String :acronym
  #String :user

  validates :value, :acronym, :user, :presence => { :message => "is required!" }

  validates :value, 
    :length => { :minimum => 1, :maximum => 80 },
    :uniqueness => { :message => "already exists!" },
    :unless => lambda{ self.value.blank? }

  validates :acronym, 
    :length => { :minimum => 1, :maximum => 1 },
    :uniqueness => { :message => "already exists!" },
    :unless => lambda{ self.acronym.blank? }

end
