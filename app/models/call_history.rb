class CallHistory < ActiveRecord::Base

  #Integer :ticket
  #Integer :wicket
  #Integer :status_ticket

  belongs_to :ticket
  belongs_to :wicket
  belongs_to :status_ticket

  validates :ticket, :wicket, :status_ticket, :presence => true

end
