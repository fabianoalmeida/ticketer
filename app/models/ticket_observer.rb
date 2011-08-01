class TicketObserver < ActiveRecord::Observer

  include TicketerIo

  def before_save(ticket)
   unless ticket.new_record?
      state_object =  StatusTicket.id_for(ticket.state)
      ticket.status_ticket = state_object unless ticket.status_ticket.eql?(state_object)
    end
  end

  def after_create(ticket)
    Rails.logger.info "Generated a new ticket: #{ticket.value}!"
  end

  def after_save(ticket)
    self.emit_ticket(:availables, ticket)
  end
 end
