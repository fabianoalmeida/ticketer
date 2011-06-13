class TicketTypeGroup < ActiveRecord::Base

  belongs_to :status
  has_and_belongs_to_many :places

  validates :value, :user, :status, :presence => true

  validates :value, 
    :length => { :maximum => 80 },
    :uniqueness => { :case_sensitive => false }
end
