module TicketManager 
  def self.included(base) 
    base.extend InstanceMethods 
  end
  
  module InstanceMethods
    def next_to(wicket)
      next_ticket = nil

      ticket_type_groups= wicket.ticket_type_groups

      if wicket.priority

        priorities= TicketType.priorities(ticket_type_groups)

        next_ticket = where(
          :place_id => wicket.place.id, 
          :ticket_type_id => priorities, 
          :status_ticket_id => StatusTicket.available.id
        ).today.order(:created_at).first
      end

      next_ticket ||= includes(:ticket_type).where(
        "ticket_types.ticket_type_group_id" => ticket_type_groups)
        .where(
        :place_id => wicket.place.id, 
        :status_ticket_id => StatusTicket.available.id
      ).today.order("tickets.created_at").first
      
      next_ticket
    end
  end
end
