class CallHistory < ActiveRecord::Base

  #Integer :ticket_id
  #Integer :wicket_id
  #Integer :call_history_type_id

  validates :ticket, :wicket, :call_history_type, :presence => { :message => "is required!" }

  has_one :ticket
  has_one :wicket
  has_one :call_history_type

end
