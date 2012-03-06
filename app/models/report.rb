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
          :attendances_by_days_per_wicket, :waiting_time_by_day_per_wicket, :waiting_time_by_month_per_wicket, 
          :waiting_time_by_client_per_month, :attendances_by_month_per_wicket

  def valid?
    @valid = valid_range_of_dates? && results? 
  end

  def to(place)
    @place = (place.is_a? Place) ? place.id : place
    self
  end

  def filtered_by(wickets)
    @wicket_ids = wickets unless wickets.nil? || wickets.empty?
    self
  end
    
  private

  def initialize(first, second, query)
    @first, @second, @query = first, second, query
  end
  
  def tickets_per_day(start_date, end_date)
    Ticket.select("to_char(trunc(created_at), 'dd/MM/yyyy' ) as date_local, count(id) as count_id")
         .where(:created_at => start_date.midnight..end_date.tomorrow.midnight)
         .where(:place_id => @place)
         .group("trunc(created_at)")
         .order("trunc(created_at) DESC")
  end

  def attendances_by_wickets_per_day(start_date, end_date)
    
    result = query_attendance_wicket(start_date, end_date)
    var_return = {}

    result.each do |r|
      var_return[r.value.to_sym] ||= {}
      (var_return[r.value.to_sym][:values] ||= []) << r.count_id
      (var_return[r.value.to_sym][:dates] ||= []) << r.date_local
    end

    var_return.to_a
  end
  
  def attendances_by_days_per_wicket(start_date, end_date)
    result = query_attendance_wicket(start_date, end_date)

    var_return = {}

    result.each do |r|
      var_return[r.date_local.to_sym] ||= {}
      (var_return[r.date_local.to_sym][:wickets] ||= [])  << r.value
      (var_return[r.date_local.to_sym][:values] ||= [])   << r.count_id
    end

    var_return.to_a
    
  end
  
  def query_attendance_wicket(start_date, end_date)
    
    filter = @wicket_ids ? { "wickets.id" => @wicket_ids } : ""

    call_histories = CallHistory.select("to_char(trunc(call_histories.created_at), 'dd/MM/yyyy' ) as date_local, wickets.value, count('call_histories.id') as count_id")
           .joins(:wicket)
           .where(  
             :created_at => start_date.midnight..end_date.tomorrow.midnight,
             :status_ticket_id => StatusTicket.attended.id,
             "wickets.place_id" => @place
           )
           .where(filter)
           .group("trunc(call_histories.created_at), wickets.value")
           .order("trunc(call_histories.created_at) DESC, wickets.value ASC")
  end
  
  def waiting_time_by_wicket(start_date, end_date)

    results = query_waiting_time_by(start_date, end_date)
    
    var_return = {}
    
    results.each do |call|
      (var_return[call.wicket_name.to_sym] ||= [])  << call
    end

    var_return.to_a
  end
  
  def waiting_time_by_day_per_wicket(start_date, end_date)

    results = query_waiting_time_by(start_date, end_date)
    
    var_return = {}
    
    results.each do |r|
      (var_return[r.data.to_sym] ||= [])  << r
    end

    var_return.to_a
  end
  
  def query_waiting_time_by(start_date, end_date)
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

    filter = @wicket_ids ? { "wickets.id" => @wicket_ids } : ""

    results = Wicket.select(select)
        .from(" wickets, #{attended_table}, #{called_table} ")
        .where(where)
        .where(filter)
        .where("called.created" => start_date.midnight..end_date.tomorrow.midnight)
        .where(:place_id => @place)
        .group("called.wicket_id, wickets.value, trunc(called.created)")
        .order("called.wicket_id, wickets.value, trunc(called.created) DESC")
    
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
    
    filter = @wicket_ids ? { "attended.wicket_id" => @wicket_ids } : ""
    
    CallHistory.select(select)  
               .from("tickets t, #{attended_table}")
               .where("attended.ticket_id = t.id")
               .where(filter)
               .where("t.created_at" => start_date.midnight..end_date.tomorrow.midnight, 
                      "t.place_id" => @place)
               .group("trunc(t.created_at)")
               .order("trunc(t.created_at)")
  end

  def attendances_by_wickets_per_month(start_date, end_date)
    
    results = query_attendance_by_wicket(start_date, end_date)
    
    var_return = {}

    results.each do | r |
      var_return[r.value.to_sym] ||= {}
      (var_return[r.value.to_sym][:values] ||=[])  << r.count_id
      (var_return[r.value.to_sym][:dates] ||=[] ) << r.date_local
    end

    var_return.to_a
    
  end
  
  def attendances_by_month_per_wicket(start_date, end_date)
    
      results = query_attendance_by_wicket(start_date, end_date)

      var_return = {}

      results.each do | r |
        var_return[r.date_local.to_sym] ||= {}
        (var_return[r.date_local.to_sym][:values] ||=[])  << r.count_id
        (var_return[r.date_local.to_sym][:dates] ||=[] ) << r.value
      end

      var_return.to_a
    
  end
  
  def query_attendance_by_wicket(start_date, end_date)

    format = "{%Y, %m, %d}"
    start  = Date.strptime("{#{start_date[:year]}, #{start_date[:month]}, 01}", format)
    finish = Date.strptime("{#{end_date[:year]}, #{end_date[:month]}, 01}", format)

    filter = @wicket_ids ? { "wickets.id" => @wicket_ids } : ""

    call_histories = CallHistory.select("wickets.value, to_char(trunc(call_histories.created_at), 'MM/yyyy') as date_local, count('call_histories.id') as count_id")
          .joins(:wicket)
          .where(filter)
          .where(
            :created_at => start..finish.end_of_month.tomorrow,
            :status_ticket_id => StatusTicket.attended.id,
            "wickets.place_id" => @place
          )
          .group("wickets.value, to_char(trunc(call_histories.created_at), 'MM/yyyy')")
          .order("wickets.value ASC, to_char(trunc(call_histories.created_at), 'MM/yyyy') DESC")    
  end
  
  def waiting_time_by_month_per_wicket(start_date, end_date)
    
    results = query_waiting_time_by_wicket_month(start_date, end_date)

    var_return = {}

    results.each do |call|
      (var_return[call.data.to_sym] ||= []) << call
    end

    var_return.to_a
  end
  
  def waiting_time_by_wicket_per_month(start_date, end_date)
  
    results = query_waiting_time_by_wicket_month(start_date, end_date)

    var_return = {}
   
    results.each do |call|
      (var_return[call.wicket_name.to_sym] ||= []) << call
    end
   
    var_return.to_a     
    
  end
  
  def query_waiting_time_by_wicket_month(start_date, end_date)
    
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

    filter = @wicket_ids ? { "id" => @wicket_ids } : ""
     
    results = Wicket.select(select)
        .from(" wickets, #{attended_table}, #{called_table} ")
        .where(where)
        .where(filter)
        .where(:place_id => @place)
        .where("called.created" => start..finish.end_of_month.tomorrow)
        .group("called.wicket_id, wickets.value, to_char(trunc(called.created), 'MM/yyyy')")
        .order("called.wicket_id, wickets.value, to_char(trunc(called.created), 'MM/yyyy') DESC")
    
  end
  
  def tickets_per_month(start_date, end_date)
    
    format = "{%Y, %m, %d}" 
    start  = Date.strptime("{#{start_date[:year]},#{start_date[:month]},01}", format)
    ending = Date.strptime("{#{end_date[:year]},#{end_date[:month]},01}", format)
   
    Ticket.select("to_char(trunc(created_at), 'MM/yyyy' ) as date_local, count(id) as count_id")
         .where(:created_at => start..ending.end_of_month.tomorrow, :place_id => @place)
         .group("to_char(trunc(created_at), 'MM/yyyy' )")
         .order("to_char(trunc(created_at), 'MM/yyyy' ) DESC")
         
  end

  def waiting_time_by_client_per_month(start_date, end_date)
    
    filter = @wicket_ids ? { "attended.wicket_id" => @wicket_ids } : ""

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
               .where(filter)
               .where("t.created_at" => start..ending.end_of_month.tomorrow, 
                      "t.place_id" => @place)
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
    
    return false if first.nil? || second.nil? 
  
    if( first.instance_of? Date) && ( second.instance_of? Date )
      return true if first <= second 
    elsif( first.kind_of? Hash ) && ( second.kind_of? Hash )
      return valid_range_of_hashes?
    end
    
    return false
  end

  def valid_range_of_hashes?
    return false if first[:year].empty? || second[:year].empty?
    return false if first[:month].empty? || second[:month].empty?

    return true if first[:year].to_i < second[:year].to_i
    return true if first[:year].to_i == second[:year].to_i && first[:month].to_i <= second[:month].to_i

    return false
  end 
end
