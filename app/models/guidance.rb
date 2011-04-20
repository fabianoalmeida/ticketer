class Guidance < ActiveRecord::Base

  #String :value
  #String :user

  has_many :wickets

  validates :value, :user, :presence => true

  validates :value,
    :length => { :in => 1..20 },
    :uniqueness => { :case_sensitive => false },
    :allow_blank => false

end
