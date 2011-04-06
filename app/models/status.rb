class Status < ActiveRecord::Base

  #String :value
  #String :user

  validates :value, :user, :presence => { :message => "it is necessary!" }

  validates :value, 
    :length => { :minimum => 1, :maximum => 80 }, 
    :uniqueness => { :message => "already exists!" },
    :if => lambda{ ! self.value.blank? }

end
