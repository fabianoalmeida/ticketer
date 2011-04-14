class CallHistoryType < ActiveRecord::Base

  #String :value
  #String :acronym
  #String :user

  has_many :call_histories

  validates :value, :acronym, :user, :presence => { :message => "is required!" }

  validates :value, 
    :length => { :in => 1..80 },
    :uniqueness => { :message => "already exists!", :case_sensitive => false },
    :allow_blank => false

  validates :acronym, 
    :length => { :is => 1 },
    :uniqueness => { :message => "already exists!", :case_sensitive => false },
    :allow_blank => false

end
