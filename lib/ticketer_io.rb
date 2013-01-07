module TicketerIo

  def self.included(base)
    base.send :include, InstanceMethods
  end # self.included

  module InstanceMethods

    #This should be moved to a module
    def emit_ticket(channel, ticket)
      
      if ticket_state_attended_or_examed?(ticket)
        channel = ticket.state.eql?(:attended.to_s) ? :attendeds : ticket.state.eql?(:examed.to_s) ? :exameds : nil
      else
        channel = [:called.to_s, :recalled.to_s ].include?(ticket.state)? :calleds : ticket.state.eql?(:available.to_s) ? :availables : nil
      end
      
      if channel
        Rails.logger.info "Publish new ticket #{ticket.value} with state #{ticket.state}, for the channel #{channel}"
        Juggernaut.publish("/ticketer", {
              :channel => channel,
              :place => ticket.place.id,
              :place_slug => ticket.place.slug,
              :value => ticket.value,
              :id => ticket.id,
              :time => I18n.localize(ticket.updated_at, :format => :hour_minute),
              :left =>  ticket.current_wicket ? ticket.current_wicket.guidance_left? : nil ,
              :right => ticket.current_wicket ? ticket.current_wicket.guidance_right? : nil ,
              :wicket_value => ticket.current_wicket ? ticket.current_wicket.value : nil,
              :ticket_type_id => ticket.ticket_type.id,
              :ticket_type_value => ticket.ticket_type.value,
              :ticket_type_group => ticket.ticket_type.ticket_type_group.value,
              :ticket_type_group_id => ticket.ticket_type.ticket_type_group.id
            })
      end
    end

    def emit_reload_panel
      Juggernaut.publish("/ticketer", {
            :channel => 'reload',
            :current_date => Date.today.strftime(I18n.t('date.formats.default'))
      })
    end
    
    private
    
    def ticket_state_attended_or_examed?(ticket)
      [:attended.to_s, :examed.to_s ].include?( ticket.state )
    end

  end # ClassMethods


end
