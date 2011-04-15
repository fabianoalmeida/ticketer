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
    :allow_blank => true

  validates :ip,
    :length => { :in => 1..15 },
    :uniqueness => { :message => "already exists!", :case_sensitive => false },
    :format => { :with => /^((?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))(?![\d])$/ },
    :allow_blank => true

end
