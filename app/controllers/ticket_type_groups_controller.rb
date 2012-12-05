class TicketTypeGroupsController < ApplicationController
  # GET /ticket_type_groups
  # GET /ticket_type_groups.xml
  def index
    @ticket_type_groups = TicketTypeGroup.actives

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ticket_type_groups.tokens(params[:q]) }
    end
  end

  # GET /ticket_type_groups/1
  # GET /ticket_type_groups/1.xml
  def show
    @ticket_type_group = TicketTypeGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ticket_type_group }
    end
  end

  # GET /ticket_type_groups/new
  # GET /ticket_type_groups/new.xml
  def new
    @ticket_type_group = TicketTypeGroup.new( :status => Status.active )

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ticket_type_group }
    end
  end

  # GET /ticket_type_groups/1/edit
  def edit
    @ticket_type_group = TicketTypeGroup.find(params[:id])
  end

  # POST /ticket_type_groups
  # POST /ticket_type_groups.xml
  def create
    @ticket_type_group = TicketTypeGroup.new(params[:ticket_type_group])
    @ticket_type_group.user = 'user test'

    respond_to do |format|
      if @ticket_type_group.save
        format.html { redirect_to(@ticket_type_group, :notice => 'Ticket type group was successfully created.') }
        format.xml  { render :xml => @ticket_type_group, :status => :created, :location => @ticket_type_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ticket_type_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ticket_type_groups/1
  # PUT /ticket_type_groups/1.xml
  def update
    @ticket_type_group = TicketTypeGroup.find(params[:id])

    respond_to do |format|
      if @ticket_type_group.update_attributes(params[:ticket_type_group])
        format.html { redirect_to(@ticket_type_group, :notice => 'Ticket type group was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ticket_type_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_type_groups/1
  # DELETE /ticket_type_groups/1.xml
  def destroy
    @ticket_type_group = TicketTypeGroup.find(params[:id])
    @ticket_type_group.status = Status.inactive
    @ticket_type_group.save
    
    respond_to do |format|
      format.html { redirect_to(ticket_type_groups_url) }
      format.xml  { head :ok }
    end
  end

  # GET /generate_ticket
  def generate_ticket
    @ticket_type_group = TicketTypeGroup.find(params[:ticket_type_group_id])

    respond_to do |format|
      format.html {render :layout => 'application-totem'}
      format.json  { render :json => @ticket_type_group }
    end
  end
end
