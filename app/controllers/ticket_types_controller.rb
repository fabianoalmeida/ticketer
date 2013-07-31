class TicketTypesController < ApplicationController
  def index
    @ticket_type_group = TicketTypeGroup.find(params[:ticket_type_group_id])
    @ticket_types = TicketType.where(:ticket_type_group_id => @ticket_type_group.id)
    respond_with(@ticket_types)
  end

  def show
    @ticket_type = TicketType.find(params[:id])
    @ticket_type_group = TicketTypeGroup.find(params[:ticket_type_group_id])
    respond_with(@ticket_type)
  end

  def new
    @ticket_type = TicketType.new( :priority => false, :status => Status.active )
    @ticket_type_group = TicketTypeGroup.find(params[:ticket_type_group_id])
    respond_with(@ticket_type)
  end

  def edit
    @ticket_type = TicketType.find(params[:id])
    @ticket_type_group = TicketTypeGroup.find(params[:ticket_type_group_id])
  end

  def create
    @ticket_type = TicketType.new(params[:ticket_type])
    @ticket_type_group = TicketTypeGroup.find(params[:ticket_type_group_id])
    @ticket_type.user = 'user test'
    flash[:notice] = "Ticket type was successfully created." if @ticket_type.save
    respond_with(@ticket_type, location: ticket_type_group_ticket_type_url(@ticket_type_group, @ticket_type))
  end

  def update
    @ticket_type = TicketType.find(params[:id])
    @ticket_type_group = TicketTypeGroup.find(params[:ticket_type_group_id])
    flash[:notice] = "Ticket type was successfully updated." if @ticket_type.update_attributes(params[:ticket_type])
    respond_with(@ticket_type, location: ticket_type_group_ticket_type_url(@ticket_type_group, @ticket_type))
  end
end
