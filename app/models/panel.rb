class Panel < ActiveRecord::Base

  #String :value
  #String :ip
  #String :user
  #Integer :status

  belongs_to :status
  belongs_to :place

  validates :value, :ip, :user, :status, :place, :presence => true 

  validates :value,
    :length => { :in => 1..80 },
    :uniqueness => { :case_sensitive => false, :scope => :place_id },
    :allow_blank => true

  validates :ip,
    :length => { :in => 1..15 },
    :uniqueness => { :case_sensitive => false },
    :format => { :with => /^((?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))(?![\d])$/ },
    :allow_blank => true

end
