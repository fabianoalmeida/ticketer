class TicketType < ActiveRecord::Base

  #String :value
  #String :acronym
  #String :user
  #Integer :status

  belongs_to :status
  has_many :tickets
  has_and_belongs_to_many :places

  validates :value, :acronym, :user, :status, :presence => true

  validates :value, 
    :length => { :in => 1..80 },
    :uniqueness => { :case_sensitive => false },
    :allow_blank => false

  validates :acronym, 
    :length => { :maximum => 3 },
    :uniqueness => { :case_sensitive => false },
    :allow_blank => false

end
