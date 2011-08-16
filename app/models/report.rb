class Report
  def self.tickets_per_day(start_date, end_date)
    Ticket.select("to_char(trunc(created_at), 'dd/MM/yyyy' ) as date_local, count(id) as count_id").where(:created_at => start_date.midnight..end_date.tomorrow.midnight).group("trunc(created_at)").order("trunc(created_at) DESC")
  end
end
