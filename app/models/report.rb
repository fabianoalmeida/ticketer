class Report
  def self.tickets_per_day(start_date, end_date)
    Ticket.select("trunc(created_at) as date_local, count(id) as count_id").where(:created_at => start_date..end_date).group("trunc(created_at)").order("trunc(created_at) DESC")
  end
end
