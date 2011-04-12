class CallHistory < ActiveRecord::Base

  #Integer :ticket_id
  #Integer :wicket_id
  #Integer :call_history_type_id

  belongs_to :ticket
  belongs_to :wicket
  belongs_to :call_history_type

  validates :ticket, :wicket, :call_history_type, :presence => { :message => "is required!" }

end
