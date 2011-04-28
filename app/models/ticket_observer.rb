class TicketObserver < ActiveRecord::Observer
  
  def before_save(ticket)
   unless ticket.new_record? 
      state_object =  StatusTicket.id_for(ticket.state)
      ticket.status_ticket = state_object unless ticket.status_ticket.eql?(state_object)
    end
    emit_ticket(:availables, ticket) 
  end

  private 
  #This should be moved to a module 
  def emit_ticket(channel, ticket)
    Juggernaut.publish(channel, {
          :value => ticket.value, 
          :id => ticket.id,
          :time => ticket.updated_at
        })
  end
 end
