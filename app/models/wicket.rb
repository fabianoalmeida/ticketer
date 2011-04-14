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

  validates :value, :user, :guidance, :status, :place, :presence => { :message => "is required!" }

  validates :value,
    :length => { :in => 1..80 },
    :uniqueness => { :message => "already exists!", :case_sensitive => false },
    :allow_blank => false

end
