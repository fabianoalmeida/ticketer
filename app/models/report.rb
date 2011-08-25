class Report
  class << self
    def tickets_per_day(start_date, end_date)
     Ticket.select("to_char(trunc(created_at), 'dd/MM/yyyy' ) as date_local, count(id) as count_id")
           .where(:created_at => start_date.midnight..end_date.tomorrow.midnight)
           .group("trunc(created_at)")
           .order("trunc(created_at) DESC")
    end

    def attendances_by_wickets_per_day(start_date, end_date)

      call_histories = CallHistory.select("wickets.value, to_char(trunc(call_histories.created_at), 'dd/MM/yyyy' ) as date_local, count('call_histories.id') as count_id")
            .joins(:wicket)
            .where(
              :created_at => start_date.midnight..end_date.tomorrow.midnight,
              :status_ticket_id => StatusTicket.called.id
            )
            .group("wickets.value, trunc(call_histories.created_at)")
            .order("wickets.value ASC, trunc(call_histories.created_at) DESC")

      var_return = {}

      call_histories.each do |call|
        var_return[call.value.to_sym] ||= {}
        var_return[call.value.to_sym][:values] ||= []
        var_return[call.value.to_sym][:dates] ||= []
        var_return[call.value.to_sym][:values]  << call.count_id
        var_return[call.value.to_sym][:dates]  << call.date_local
      end

      var_return.to_a
    end

    def waiting_time_by_wicket(start_date, end_date)
      called_table = <<-SQL
        (SELECT call_histories.wicket_id, call_histories.ticket_id, max(call_histories.created_at) as created
           FROM call_histories
           WHERE call_histories.status_ticket_id = #{StatusTicket.called.id}
           GROUP BY call_histories.ticket_id, call_histories.wicket_id
           ORDER BY call_histories.wicket_id, call_histories.ticket_id) called
      SQL

      attended_table = <<-SQL
        (SELECT call_histories.wicket_id, call_histories.ticket_id, max(call_histories.created_at) as created
           FROM call_histories
           WHERE call_histories.status_ticket_id = #{StatusTicket.attended.id}
           GROUP BY call_histories.ticket_id, call_histories.wicket_id
           ORDER BY call_histories.wicket_id, call_histories.ticket_id) attended
      SQL

      select = <<-SQL
        called.wicket_id, wickets.value as wicket_name , to_char(trunc(called.created), 'dd/MM/yyyy') as data , count(called.ticket_id) as total , avg(attended.created-called.created) * 24 as time
      SQL

        where = <<-SQL
        attended.wicket_id = called.wicket_id
        and attended.ticket_id = called.ticket_id
        and attended.wicket_id = wickets.id
        and called.wicket_id = wickets.id
      SQL

      results = Wicket.select(select)
          .from(" wickets, #{attended_table}, #{called_table} ")
          .where(where)
            .where("called.created" => start_date.midnight..end_date.tomorrow.midnight)
          .group("called.wicket_id, wickets.value, trunc(called.created)")
          .order("called.wicket_id, wickets.value, trunc(called.created) DESC")
          
      var_return = {}
     
      results.each do |call|
        var_return[call.wicket_name.to_sym] ||= []
        var_return[call.wicket_name.to_sym] << call
      end
     
      var_return.to_a
    end
    
    def waiting_time_by_client(start_date, end_date)
      attended_table = <<-SQL
        (SELECT call_histories.wicket_id, call_histories.ticket_id, max(call_histories.created_at) as created
           FROM call_histories
           WHERE call_histories.status_ticket_id = #{StatusTicket.attended.id}
           GROUP BY call_histories.ticket_id, call_histories.wicket_id
           ORDER BY call_histories.wicket_id, call_histories.ticket_id) attended
      SQL
      
      select = <<-SQL 
        to_char(trunc(t.created_at), 'dd/MM/yyyy') as data, count(attended.ticket_id) as total, avg(attended.created - t.created_at) * 24  as time
      SQL
      
      CallHistory.select(select)  
                 .from("tickets t, #{attended_table}")
                 .where("attended.ticket_id = t.id")
                 .where("t.created_at" => start_date.midnight..end_date.tomorrow.midnight)
                 .group("trunc(t.created_at)")
                 .order("trunc(t.created_at)")
    end
  end #end Class#Self
end
