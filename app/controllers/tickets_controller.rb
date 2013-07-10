class TicketsController < ApplicationController
  def create
    @ticket               = Ticket.new(params[:ticket])
    @ticket.status_ticket = StatusTicket.available
    @ticket.place         = Place.find(params[:ticket][:place_id])
    @ticket.totem         = Totem.find(params[:ticket][:totem_id])
    if @ticket.save
      flash[:notice] = "Ticket was successfully created."
      TicketPrint.print(@ticket)
      @ticket[:created_at_formatted] = I18n.localize(@ticket.created_at.localtime, format: :default)
      @ticket[:ticket_type_value]    = @ticket.ticket_type.value.to_s
      @ticket[:place_value]          = @ticket.place.value.to_s
    end
    respond_with(@ticket)
  end
end
