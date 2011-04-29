class TicketObserver < ActiveRecord::Observer
  
  def before_save(ticket)
   unless ticket.new_record? 
      state_object =  StatusTicket.id_for(ticket.state)
      ticket.status_ticket = state_object unless ticket.status_ticket.eql?(state_object)
    end
  end

  def after_save(ticket)
    emit_ticket(:availables, ticket) 
  end

  private 
  #This should be moved to a module 
  def emit_ticket(channel, ticket)
    channel = [:called.to_s, :recalled.to_s ].include?(ticket.state)? :calleds : ticket.state.eql?(:available.to_s) ? :availables : nil 

    if channel 
      Rails.logger.info "Publihs new ticket #{ticket.value} com a ação #{ticket.state}, para o canal #{channel}"
      Juggernaut.publish(channel, {
            :value => ticket.value, 
            :id => ticket.id,
            :time => ticket.updated_at
          })
    end
  end
 end
