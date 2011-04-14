class Panel < ActiveRecord::Base

  #String :value
  #String :ip
  #String :user
  #Integer :status

  belongs_to :status
  belongs_to :place

  validates :value, :ip, :user, :status, :place, :presence => { :message => "is required!" }

  validates :value,
    :length => { :in => 1..80 },
    :uniqueness => { :message => "already exists!", :case_sensitive => false },
    :allow_blank => false

  validates :ip,
    :length => { :in => 1..15 },
    :uniqueness => { :message => "already exists!", :case_sensitive => false },
    :allow_blank => false

end
