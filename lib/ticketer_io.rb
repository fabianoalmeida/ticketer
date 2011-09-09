module TicketerIo
  
  def self.included(base)
    base.send :include, InstanceMethods
  end # self.included

  module InstanceMethods
    
    #This should be moved to a module
    def emit_ticket(channel, ticket)
      channel = [:called.to_s, :recalled.to_s ].include?(ticket.state)? :calleds : ticket.state.eql?(:available.to_s) ? :availables : nil

      if channel
        Rails.logger.info "Publish new ticket #{ticket.value} with state #{ticket.state}, for the channel #{channel}"
        Ticketer.redis.publish("/ticketer", ({
              :channel => channel,
              :place => ticket.place.id,
              :value => ticket.value,
              :id => ticket.id,
              :time => I18n.localize(ticket.updated_at, :format => :hour_minute),
              :left =>  ticket.current_wicket ? ticket.current_wicket.guidance_left? : nil ,
              :right => ticket.current_wicket ? ticket.current_wicket.guidance_right? : nil ,
              :wicket_value => ticket.current_wicket ? ticket.current_wicket.value : nil,
              :ticket_type_id => ticket.ticket_type.id,
              :ticket_type_value => ticket.ticket_type.value,
              :ticket_type_group => ticket.ticket_type.ticket_type_group.value
            }).to_json)
      end
    end

    def emit_reload_panel
      Ticketer.redis.publish("/ticketer", {
            :channel => 'reload',
            :current_date => Date.today.strftime(I18n.t('date.formats.default'))
      })
    end

  end # ClassMethods


end
