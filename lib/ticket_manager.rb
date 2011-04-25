module TicketManager 
  def self.included(base) 
    base.send(:extend, TicketManagerClass )
  end

  module TicketManagerClass
    def next_to(place) 
      next_ticket = Ticket.where(:place_id => place.id, :ticket_type_id => TicketType.preferencial.id, :ticket_state_id => TicketState.opened.id).order(:createed_at).last 

      next_ticket ||= Ticket.where(:place_id => place.id, :ticket_type_id => TicketType.normal.id, :ticket_state_id => TicketState.opened.id).order(:createed_at).last 

      next_ticket
    end
  end
end
