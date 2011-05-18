class TicketObserver < ActiveRecord::Observer
  
  def before_save(ticket)
   unless ticket.new_record? 
      state_object =  StatusTicket.id_for(ticket.state)
      ticket.status_ticket = state_object unless ticket.status_ticket.eql?(state_object)
    end
  end

  def after_save(ticket)
    Rails.logger.info "Generated a new ticket: #{ticket.value}!"
    emit_ticket(:availables, ticket) 
  end

  private 
  #This should be moved to a module 
  def emit_ticket(channel, ticket)
    channel = [:called.to_s, :recalled.to_s ].include?(ticket.state)? "calleds#{ticket.place.id}" : ticket.state.eql?(:available.to_s) ? "availables#{ticket.place.id}" : nil 

    if channel 
      Rails.logger.info "Publish new ticket #{ticket.value} with state #{ticket.state}, for the channel #{channel}"
      Juggernaut.publish(channel, {
            :value => ticket.value, 
            :id => ticket.id,
            :time => I18n.localize(ticket.updated_at, :format => :hour_minute),
            :left =>  ticket.current_wicket ? ticket.current_wicket.guidance_left? : nil ,
            :right => ticket.current_wicket ? ticket.current_wicket.guidance_right? : nil ,
            :wicket_value => ticket.current_wicket ? ticket.current_wicket.value : nil,
            :ticket_type_value => ticket.ticket_type.value
          })
    end
  end
 end
