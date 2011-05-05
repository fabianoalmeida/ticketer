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
    channel = [:called.to_s, :recalled.to_s ].include?(ticket.state)? :calleds : ticket.state.eql?(:available.to_s) ? :availables : nil 

    if channel 
      debugger
      Rails.logger.info "Publish new ticket #{ticket.value} wiht stat #{ticket.state}, for the channel #{channel}"
      Juggernaut.publish(channel, {
            :value => ticket.value, 
            :id => ticket.id,
            :time => I18n.localize(ticket.updated_at, :format => :default),
            :left => ticket.wickets.last.guidance_left?,
            :right => ticket.wickets.last.guidance_right? ,
            :wicket => ticket.wickets.last.to_json
          })
    end
  end
 end
