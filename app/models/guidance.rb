class Guidance < ActiveRecord::Base

  #String :value
  #String :user

  has_many :wickets

  validates :value, :user, :presence => { :message => "is required!" }

  validates :value,
    :length => { :in => 1..20 },
    :uniqueness => { :message => "already exists!", :case_sensitive => false },
    :allow_blank => false

end
