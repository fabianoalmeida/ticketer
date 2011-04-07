class Status < ActiveRecord::Base

  #String :value
  #String :user

  validates :value, :user, :presence => { :message => "is required!" }

  validates :value, 
    :length => { :minimum => 1, :maximum => 80 }, 
    :uniqueness => { :message => "already exists!" },
    :unless => lambda{ self.value.blank? }

end
