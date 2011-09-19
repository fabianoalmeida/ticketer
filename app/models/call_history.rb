class CallHistory < ActiveRecord::Base

  #Integer :ticket
  #Integer :wicket
  #Integer :status_ticket

  belongs_to :ticket
  belongs_to :wicket
  belongs_to :status_ticket

  validates :ticket, :wicket, :status_ticket, :presence => true

  def self.register(record={})
    return false if record.empty?
    self.create(:ticket => record[:ticket], :status_ticket => record[:ticket].status_ticket, :wicket => record[:wicket])

  end

  def self.last_wicket_to_call(ticket)
    where(:ticket_id => ticket.id, :status_ticket_id => StatusTicket.called.id).order(:created_at).last.wicket
  end
end
