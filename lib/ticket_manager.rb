module TicketManager 
  def self.included(base) 
    base.extend InstanceMethods 
  end
  
  module InstanceMethods
    def next_to(place)
      place= place.id if place.is_a? Place
      next_ticket = where(:place_id => place, :ticket_type_id => TicketType.preferencial.id, :status_ticket_id => StatusTicket.available.id).today.order(:created_at).first
      next_ticket ||= where(:place_id => place, :status_ticket_id => StatusTicket.available.id).today.order(:created_at).first
      next_ticket
    end
  end
end
