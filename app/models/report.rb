class Report
  
  attr_accessor :first, :second, :query
  attr_reader :error, :valid, :results
  
  def self.queries(*args) 
    args.each do |query| 
      instance_eval do 
        define_singleton_method query do |first, second|
          new( first , second,  query)
        end 
      end
    end
  end    

  queries :tickets_per_day, :waiting_time_by_client, :waiting_time_by_wicket, :attendances_by_wickets_per_day,
          :tickets_per_month, :waiting_time_by_wicket_per_month, :attendances_by_wickets_per_month, 
          :attendances_by_days_per_wicket, :waiting_time_by_day_per_wicket, :waiting_time_by_client_per_month

  def valid?
    @valid = valid_range_of_dates? && results? 
  end
    
  private

  def initialize(first, second, query)
    @first, @second, @query = first, second, query
  end
  
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
      called.wicket_id, wickets.value as wicket_name , to_char(trunc(called.created), 'dd/MM/yyyy') as data , count(called.ticket_id) as total , avg(attended.created-called.created) * 24 * 60 as time
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
      to_char(trunc(t.created_at), 'dd/MM/yyyy') as data, count(attended.ticket_id) as total, avg(attended.created - t.created_at) * 24 * 60 as time
    SQL
    
    CallHistory.select(select)  
               .from("tickets t, #{attended_table}")
               .where("attended.ticket_id = t.id")
               .where("t.created_at" => start_date.midnight..end_date.tomorrow.midnight)
               .group("trunc(t.created_at)")
               .order("trunc(t.created_at)")
  end

  def attendances_by_wickets_per_month(start_date, end_date)

    format = "{%Y, %m, %d}"
    start  = Date.strptime("{#{start_date[:year]}, #{start_date[:month]}, 01}", format)
    finish = Date.strptime("{#{end_date[:year]}, #{end_date[:month]}, 01}", format)

    call_histories = CallHistory.select("wickets.value, to_char(trunc(call_histories.created_at), 'MM/yyyy') as date_local, count('call_histories.id') as count_id")
          .joins(:wicket)
          .where(
            :created_at => start..finish.end_of_month.tomorrow,
            :status_ticket_id => StatusTicket.called.id
          )
          .group("wickets.value, to_char(trunc(call_histories.created_at), 'MM/yyyy')")
          .order("wickets.value ASC, to_char(trunc(call_histories.created_at), 'MM/yyyy') DESC")

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
  

  def waiting_time_by_wicket_per_month(start_date, end_date)

    format = "{%Y, %m, %d}"
    start  = Date.strptime("{#{start_date[:year]}, #{start_date[:month]}, 01}", format)
    finish = Date.strptime("{#{end_date[:year]}, #{end_date[:month]}, 01}", format)

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
      called.wicket_id, wickets.value as wicket_name , to_char(trunc(called.created), 'MM/yyyy') as data , count(called.ticket_id) as total , avg(attended.created-called.created) * 24 * 60 as time
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
        .where("called.created" => start..finish.end_of_month.tomorrow)
        .group("called.wicket_id, wickets.value, to_char(trunc(called.created), 'MM/yyyy')")
        .order("called.wicket_id, wickets.value, to_char(trunc(called.created), 'MM/yyyy') DESC")
        
    var_return = {}
   
    results.each do |call|
      var_return[call.wicket_name.to_sym] ||= []
      var_return[call.wicket_name.to_sym] << call
    end
   
    var_return.to_a     
  end
  
  def tickets_per_month(start_date, end_date)
    
    format = "{%Y, %m, %d}" 
    start  = Date.strptime("{#{start_date[:year]},#{start_date[:month]},01}", format)
    ending = Date.strptime("{#{end_date[:year]},#{end_date[:month]},01}", format)
   
    Ticket.select("to_char(trunc(created_at), 'MM/yyyy' ) as date_local, count(id) as count_id")
         .where(:created_at => start..ending.end_of_month.tomorrow)
         .group("to_char(trunc(created_at), 'MM/yyyy' )")
         .order("to_char(trunc(created_at), 'MM/yyyy' ) DESC")
         
  end

  def attendances_by_days_per_wicket(start_date, end_date)

      call_histories = CallHistory.select("to_char(trunc(call_histories.created_at), 'dd/MM/yyyy' ) as date_local, wickets.value, count('call_histories.id') as count_id")
            .joins(:wicket)
            .where(
              :created_at => start_date.midnight..end_date.tomorrow.midnight,
              :status_ticket_id => StatusTicket.called.id
            )
            .group("trunc(call_histories.created_at), wickets.value")
            .order("trunc(call_histories.created_at) DESC, wickets.value ASC")

      var_return = {}

      call_histories.each do |call|
        var_return[call.date_local.to_sym]           ||= {}
        var_return[call.date_local.to_sym][:wickets] ||= []
        var_return[call.date_local.to_sym][:values]  ||= []
        var_return[call.date_local.to_sym][:wickets]  << call.value
        var_return[call.date_local.to_sym][:values]   << call.count_id
      end

      var_return.to_a
  end

  def waiting_time_by_day_per_wicket(start_date, end_date)

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
      to_char(trunc(called.created), 'dd/MM/yyyy') as data, called.wicket_id, wickets.value as wicket_name, count(called.ticket_id) as total, avg(attended.created-called.created) * 24 * 60 as time
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
        .group("trunc(called.created), called.wicket_id, wickets.value")
        .order("trunc(called.created) DESC, called.wicket_id, wickets.value")
        
    var_return = {}
   
    results.each do |call|
      var_return[call.data.to_sym] ||= []
      var_return[call.data.to_sym] << call
    end
   
    var_return.to_a
  end

  def waiting_time_by_client_per_month(start_date, end_date)

    format = "{%Y, %m, %d}" 
    start  = Date.strptime("{#{start_date[:year]},#{start_date[:month]},01}", format)
    ending = Date.strptime("{#{end_date[:year]},#{end_date[:month]},01}", format)
   
    attended_table = <<-SQL
      (SELECT call_histories.wicket_id, call_histories.ticket_id, max(call_histories.created_at) as created
         FROM call_histories
         WHERE call_histories.status_ticket_id = #{StatusTicket.attended.id}
         GROUP BY call_histories.ticket_id, call_histories.wicket_id
         ORDER BY call_histories.wicket_id, call_histories.ticket_id) attended
    SQL
    
    select = <<-SQL 
      to_char(trunc(t.created_at), 'MM/yyyy') as data, count(attended.ticket_id) as total, avg(attended.created - t.created_at) * 24 * 60 as time
    SQL
    
    CallHistory.select(select)  
               .from("tickets t, #{attended_table}")
               .where("attended.ticket_id = t.id")
               .where("t.created_at" => start..ending.end_of_month.tomorrow)
               .group("to_char(trunc(t.created_at), 'MM/yyyy')")
               .order("to_char(trunc(t.created_at), 'MM/yyyy') DESC")
  end

  def results? 
    if valid_range_of_dates?
      @results = send(query, first, second)
    end
    ((@results && ! @results.empty?) || false )
  end

  def valid_range_of_dates?

    return false  if first.nil? || second.nil? 
  
    if( first.instance_of? Date) && ( second.instance_of? Date )
      return true if first <= second 
    elsif( first.kind_of? Hash ) && ( second.kind_of? Hash )
      return true if first[:year].to_i < second[:year].to_i
      return true if first[:year].to_i == second[:year].to_i && first[:month].to_i <= second[:month].to_i
    end
    error = "Range invalido!"
    return false
  
  end

end
