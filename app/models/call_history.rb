class CallHistory < ActiveRecord::Base

  #Integer :ticket
  #Integer :wicket
  #Integer :call_history_type

  belongs_to :ticket
  belongs_to :wicket
  belongs_to :call_history_type

  validates :ticket, :wicket, :call_history_type, :presence => { :message => "is required!" }

end
