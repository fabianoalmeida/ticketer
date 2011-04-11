class Wicket < ActiveRecord::Base

  #String :value
  #String :user
  #Integer :guidance_id
  #Integer :status_id

  validates :value, :user, :guidance_id, :status_id, :presence => { :message => "is required!" }

  validates :value,
    :length => { :minimum => 1, :maximum => 80 },
    :uniqueness => { :message => "already exists!" },
    :unless => lambda{ self.value.blank? }
  
  has_one :guidance
  has_one :status

end
