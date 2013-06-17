class Totem < ActiveRecord::Base
  extend FriendlyId
  
  friendly_id :value, use: :slugged

  #String :value
  #String :ip
  #String :user

  belongs_to :status
  belongs_to :place
  belongs_to :printer
  has_many :tickets

  validates :value, :ip, :user, :status, :place, :printer, :presence => true

  validates :value,
    :length => { :in => 1..80 },
    :uniqueness => { :case_sensitive => false, :scope => :place_id },
    :allow_blank => true

  validates :ip,
    :length => { :in => 1..15 },
    :uniqueness => true,
    :format => { :with => /^((?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))(?![\d])$/ },
    :allow_blank => true

end
