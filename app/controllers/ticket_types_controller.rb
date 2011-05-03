class TicketTypesController < ApplicationController
  # GET /ticket_types
  # GET /ticket_types.json
  def index
    @ticket_types = TicketType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @ticket_types }
    end
  end

  # GET /ticket_types/1
  # GET /ticket_types/1.json
  def show
    @ticket_type = TicketType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @ticket_type }
    end
  end

  # GET /ticket_types/new
  # GET /ticket_types/new.json
  def new
    @ticket_type = TicketType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @ticket_type }
    end
  end

  # GET /ticket_types/1/edit
  def edit
    @ticket_type = TicketType.find(params[:id])
  end

  # POST /ticket_types
  # POST /ticket_types.json
  def create
    @ticket_type = TicketType.new(params[:ticket_type])
    @ticket_type.status = Status.active
    @ticket_type.user = 'user test'

    respond_to do |format|
      if @ticket_type.save
        format.html { redirect_to(@ticket_type, :notice => 'Ticket type was successfully created.') }
        format.json  { render :json => @ticket_type, :status => :created, :location => @ticket_type }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @ticket_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ticket_types/1
  # PUT /ticket_types/1.json
  def update
    @ticket_type = TicketType.find(params[:id])

    respond_to do |format|
      if @ticket_type.update_attributes(params[:ticket_type])
        format.html { redirect_to(@ticket_type, :notice => 'Ticket type was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @ticket_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_types/1
  # DELETE /ticket_types/1.json
  def destroy
    @ticket_type = TicketType.find(params[:id])
    @ticket_type.destroy

    respond_to do |format|
      format.html { redirect_to(ticket_types_url) }
      format.json  { head :ok }
    end
  end
end
