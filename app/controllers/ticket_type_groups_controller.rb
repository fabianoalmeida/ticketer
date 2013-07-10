class TicketTypeGroupsController < ApplicationController
  def index
    @ticket_type_groups = TicketTypeGroup.actives
    respond_with(@ticket_type_groups.tokens(params[:q]))
  end

  def show
    @ticket_type_group = TicketTypeGroup.find(params[:id])
    respond_with(@ticket_type_group)
  end

  def new
    @ticket_type_group = TicketTypeGroup.new(status: Status.active)
    respond_with(@ticket_type_group)
  end

  def edit
    @ticket_type_group = TicketTypeGroup.find(params[:id])
  end

  def create
    @ticket_type_group = TicketTypeGroup.new(params[:ticket_type_group])
    @ticket_type_group.user = 'user test'
    flash[:notice] = "Ticket type group was successfully created." if @ticket_type_group.save
    respond_with(@ticket_type_group)
  end

  def update
    @ticket_type_group = TicketTypeGroup.find(params[:id])
    flash[:notice] = "Ticket type group was successfully updated." if @ticket_type_group.update_attributes(params[:ticket_type_group])
    respond_with(@ticket_type_group)
  end

  def generate_ticket
    @ticket_type_group = TicketTypeGroup.find(params[:ticket_type_group_id])
    respond_with(@ticket_type_group) do |format|
      format.html { render :layout => 'application-totem' }
    end
  end
end
