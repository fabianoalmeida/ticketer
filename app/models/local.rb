class Local < ActiveRecord::Base

  #String :value
  #Integer :status_id
  #String :user
  
  validates :value, :status, :user, :presence => { :message => "is required!" }

  validates :value,
    :length => { :minimum => 1, :maximum => 80 },
    :uniqueness => { :message => "already exists!" },
    :unless => lambda{ self.value.blank? }

  has_one :status

end
