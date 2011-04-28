class TicketObserver < ActiveRecord::Observer
  
  def before_save(ticket)

   unless ticket.new_record? 
      state_object =  StatusTicket.id_for(ticket.state)
      ticket.status_ticket = state_object unless ticket.status_ticket.eql?(state_object)
    end
   #here goes the Juggernaut#publish to notify a new ticket available
  end

 end
