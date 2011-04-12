class StatusTicketsController < ApplicationController
  # GET /status_tickets
  # GET /status_tickets.xml
  def index
    @status_tickets = StatusTicket.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @status_tickets }
    end
  end

  # GET /status_tickets/1
  # GET /status_tickets/1.xml
  def show
    @status_ticket = StatusTicket.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @status_ticket }
    end
  end

  # GET /status_tickets/new
  # GET /status_tickets/new.xml
  def new
    @status_ticket = StatusTicket.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @status_ticket }
    end
  end

  # GET /status_tickets/1/edit
  def edit
    @status_ticket = StatusTicket.find(params[:id])
  end

  # POST /status_tickets
  # POST /status_tickets.xml
  def create
    @status_ticket = StatusTicket.new(params[:status_ticket])
    @status_ticket.user = "user test"

    respond_to do |format|
      if @status_ticket.save
        format.html { redirect_to(@status_ticket, :notice => 'Status ticket was successfully created.') }
        format.xml  { render :xml => @status_ticket, :status => :created, :location => @status_ticket }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @status_ticket.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /status_tickets/1
  # PUT /status_tickets/1.xml
  def update
    @status_ticket = StatusTicket.find(params[:id])

    respond_to do |format|
      if @status_ticket.update_attributes(params[:status_ticket])
        format.html { redirect_to(@status_ticket, :notice => 'Status ticket was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @status_ticket.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /status_tickets/1
  # DELETE /status_tickets/1.xml
  def destroy
    @status_ticket = StatusTicket.find(params[:id])
    @status_ticket.destroy

    respond_to do |format|
      format.html { redirect_to(status_tickets_url) }
      format.xml  { head :ok }
    end
  end
end
