class Totem < ActiveRecord::Base

  #String :value
  #String :ip
  #String :user
  #Integer :status_id

  belongs_to :status
  belongs_to :place

  validates :value, :ip, :user, :status, :presence => { :message => "is required!" }

  validates :value,
    :length => { :minimum => 1, :maximum => 80 },
    :uniqueness => { :message => "already exists!" },
    :unless => lambda{ self.value.blank? }

  validates :ip,
    :length => { :minimum => 1, :maximum => 15 },
    :uniqueness => { :message => "already exists!" },
    :unless => lambda{ self.ip.blank? }

end
