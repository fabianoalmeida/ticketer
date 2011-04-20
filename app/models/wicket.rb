class Wicket < ActiveRecord::Base

  #String :value
  #String :user
  #Integer :guidance
  #Integer :status
  #Integer :place

  belongs_to :guidance
  belongs_to :status
  belongs_to :place
  has_many :call_histories

  validates :value, :user, :guidance, :status, :place, :presence => true

  validates :value,
    :length => { :in => 1..80 },
    :uniqueness => { :case_sensitive => false },
    :allow_blank => false

end
