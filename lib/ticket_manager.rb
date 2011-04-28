module TicketManager 
  def self.included(base) 
    base.send(:extend, TicketManagerClass )
  end

  module TicketManagerClass
    def next_to(place)

      place= place.id if place.is_a? Place

      next_ticket = where(:place_id => place, :ticket_type_id => TicketType.preferencial.id, :status_ticket_id => StatusTicket.available.id).today.order(:created_at).first

      next_ticket ||= where(:place_id => place, :status_ticket_id => StatusTicket.available.id).today.order(:created_at).first

      next_ticket
    end

    def today
      #TODO Move to module
      where(:created_at => Date.today.midnight...Date.tomorrow.midnight)
    end

    def available_for_place(place)

      place= place.id if place.is_a? Place

      tickets = where(:place_id => place, :status_ticket_id => StatusTicket.available.id).today

      tickets
    end

    def called_for_place(place)

      place= place.id if place.is_a? Place

      tickets = where(:place_id => place, :status_ticket_id => StatusTicket.called.id).today

      tickets
    end
  end

  def log_history(state_transition)
    update_attributes(:status_ticket => StatusTicket.state_id_for(state_transition.to))
  end
end
