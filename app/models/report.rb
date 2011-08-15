class Report
  def self.tickets_per_day(start_date, end_date)
   Ticket.where(:created_at => start_date..end_date).count(:group => ["TO_CHAR(created_at, 'dd/MM/yyyy')"])
  end
end
