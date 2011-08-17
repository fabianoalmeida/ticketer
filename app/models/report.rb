class Report
  def self.tickets_per_day(start_date, end_date)
    tickets = Ticket.select("to_char(trunc(created_at), 'dd/MM/yyyy' ) as date_local, count(id) as count_id")
          .where(:created_at => start_date.midnight..end_date.tomorrow.midnight)
          .group("trunc(created_at)")
          .order("trunc(created_at) DESC")

    tickets
  end

  def self.attendances_by_wickets_per_day(start_date, end_date)
    call_histories = CallHistory.select("wickets.value, to_char(trunc(call_histories.created_at), 'dd/MM/yyyy' ) as date_local, count('call_histories.id') as count_id")
          .joins(:wicket)
          .where(
            :created_at => start_date.midnight..end_date.tomorrow.midnight, 
            :status_ticket_id => StatusTicket.called.id
          )
          .group("wickets.value, trunc(call_histories.created_at)")
          .order("wickets.value ASC, trunc(call_histories.created_at) DESC")
    call_histories
  end
end
