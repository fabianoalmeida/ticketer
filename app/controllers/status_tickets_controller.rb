class StatusTicketsController < ApplicationController
  def index
    @status_tickets = StatusTicket.all
    respond_with(@status_tickets)
    end
  end

  def show
    @status_ticket = StatusTicket.find(params[:id])
    respond_with(@status_ticket)
  end

  def new
    @status_ticket = StatusTicket.new
    respond_with(@status_ticket)
  end

  def edit
    @status_ticket = StatusTicket.find(params[:id])
  end

  def create
    @status_ticket = StatusTicket.new(params[:status_ticket])
    @status_ticket.user = "user test"
    flash[:notice] = "Status ticket was successfully created." if @status_ticket.save
    respond_with(@status_ticket)
  end

  def update
    @status_ticket = StatusTicket.find(params[:id])
    flash[:notice] = "Status ticket was successfully updated." if @status_ticket.update_attributes(params[:status_ticket])
    respond_with(@status_ticket)
  end
end
