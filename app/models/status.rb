class Status < ActiveRecord::Base

  #String :value
  #String :user

  validates :value, :user, :presence => { :message => "is required!" }

  validates :value, 
    :length => { :minimum => 1, :maximum => 80 }, 
    :uniqueness => { :message => "already exists!" },
    :unless => lambda{ self.value.blank? }

  scope :active, where( { :value => "Active" } )
  scope :inactive, where( { :value => "Inactive" } )

end
