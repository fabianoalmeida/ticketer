class Wicket < ActiveRecord::Base

  #String :value
  #String :user
  #Integer :guidance_id
  #Integer :status_id

  belongs_to :guidance
  belongs_to :status
  has_many :call_histories

  validates :value, :user, :guidance, :status, :presence => { :message => "is required!" }

  validates :value,
    :length => { :minimum => 1, :maximum => 80 },
    :uniqueness => { :message => "already exists!" },
    :unless => lambda{ self.value.blank? }

end
