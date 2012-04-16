module TicketManager 
  def self.included(base) 
    base.extend InstanceMethods 
  end
  
  module InstanceMethods
    def next_to(wicket)
      next_ticket   = nil
      next_ticket   = next_priority(wicket)  if wicket.priority
      next_ticket ||= next_alternate(wicket) if wicket.alternate
      next_ticket ||= next_default(wicket)
      next_ticket ||= next_reference(wicket)
      next_ticket
    end
    
    private
    
    def next_priority(wicket, priority = true)
      next_ticket= nil
      priorities= TicketType.priorities(wicket.ticket_type_groups, priority)

      next_ticket = where(
        :place_id => wicket.place.id, 
        :ticket_type_id => priorities, 
        :status_ticket_id => StatusTicket.available.id
      ).today.order(:created_at).first
      next_ticket
    end
    
    def next_alternate(wicket)
      last_ticket = wicket.tickets.today.where(:status_ticket_id => StatusTicket.attended.id).order(:updated_at).last
      return last_ticket unless last_ticket
      
      ticket_type = last_ticket.ticket_type
      return next_ticket = next_priority( wicket, false ) if ticket_type.priority
      return next_ticket = next_priority( wicket ) unless ticket_type.priority
    end
    
    def next_default(wicket)
      next_ticket = nil
      next_ticket = includes(:ticket_type)
        .where( "ticket_types.ticket_type_group_id" => wicket.ticket_type_groups )
        .where( :place_id => wicket.place.id, :status_ticket_id => StatusTicket.available.id )
        .today.order("tickets.created_at").first
      next_ticket
    end
    
    def next_reference(wicket)
      next_ticket = nil
      
      if wicket.has_reference?
        next_ticket = includes(:ticket_type)
          .where( "ticket_types.ticket_type_group_id" => wicket.reference_groups )
          .where( :place_id => wicket.place.id, :status_ticket_id => StatusTicket.available.id )
          .today.order("tickets.created_at").first
      end
      
      next_ticket
    end
  end
end
