class WicketsController < ApplicationController
  # GET /wickets
  # GET /wickets.json
  def index
    @place = Place.find(params[:place_id])
    @wickets = Wicket.where(:place_id => @place.id).order( "value ASC" )

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @wickets }
    end
  end

  # GET /wickets/1
  # GET /wickets/1.json
  def show
    @wicket = Wicket.find(params[:id])
    @place = Place.find(params[:place_id])
    @ticket_type_groups = @place.ticket_type_groups.order( "value ASC" )
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @wicket }
    end
  end

  # GET /wickets/new
  # GET /wickets/new.json
  def new
    @wicket = Wicket.new( :priority => false )
    @place = Place.find(params[:place_id])
    @ticket_type_groups = @place.ticket_type_groups.order( "value ASC" )
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @wicket }
    end
  end

  # GET /wickets/1/edit
  def edit
    @wicket = Wicket.find(params[:id])
    @place = Place.find(params[:place_id])
    @ticket_type_groups = @place.ticket_type_groups.order( "value ASC" )
  end

  # POST /wickets
  # POST /wickets.json
  def create
    debugger
    @wicket = Wicket.new(params[:wicket])
    @place = Place.find(params[:place_id])
    @ticket_type_groups = @place.ticket_type_groups.order( "value ASC" )
    @wicket.user= "user test"

    respond_to do |format|
      if @wicket.save
        format.html { redirect_to(place_wicket_url(@place, @wicket), :notice => 'Wicket was successfully created.') }
        format.json  { render :json => @wicket, :status => :created, :location => @wicket }
      else
        format.html { render :action => :new }
        format.json  { render :json => @wicket.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /wickets/1
  # PUT /wickets/1.json
  def update
    @wicket = Wicket.find(params[:id])
    @place = Place.find(params[:place_id])
    @ticket_type_groups = @wicket.ticket_type_groups.order( "value ASC" )

    respond_to do |format|
      if @wicket.update_attributes(params[:wicket])
        format.html { redirect_to(place_wicket_url(@place, @wicket), :notice => 'Wicket was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @wicket.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /wickets/1
  # DELETE /wickets/1.json
  def destroy
    @place  = Place.find(params[:place_id])
    @wicket = Wicket.find(params[:id])
    @wicket.status = Status.inactive
    @wicket.save

    respond_to do |format|
      format.html { redirect_to(place_wickets_url(@place)) }
      format.json  { head :ok }
    end
  end

  # GET /wicket/1/tickets
  def tickets
    @wicket = Wicket.find(params[:wicket_id])
    @place =  Place.find(params[:place_id])

    @tickets_type= []

    @wicket.ticket_type_groups.each do |ticket_type_group|
      @tickets_type << ticket_type_group.ticket_types
    end

    @tickets_type= @tickets_type.flatten

    @tickets_available = @place.tickets_availables(@wicket.ticket_type_groups).today unless @wicket.second_level?
    @tickets_available ||= @place.tickets_attended(@wicket.ticket_type_groups).today 

    if @wicket.priority
      @tickets_available = @tickets_available.sort do |a, b|
        (a.ticket_type.priority == b.ticket_type.priority) ? ((a.created_at < b.created_at) ? -1 : 1) : (a.ticket_type.priority ? -1 : 1)
      end
    end

    @tickets_attended = nil
    @tickets_called   = nil 
    @tickets_waiting  = nil 

    unless @wicket.second_level?
      @tickets_attended = @wicket.attended_tickets.today
      @tickets_called   = @wicket.called_tickets.today
      @tickets_waiting  = @wicket.pending_tickets.today
    end

    @tickets_attended ||= @wicket.examed_tickets.today
    @tickets_called   ||= []
    @tickets_waiting  ||= []
    render :layout => 'application-external'
  end

  #GET places/1/wicket/1/call_next
  def call_next
    @wicket = Wicket.find(params[:wicket_id])
    @next_ticket = Ticket.next_to(@wicket)
    @next_ticket.current_wicket= @wicket if @next_ticket
    respond_to do |format|
      if @next_ticket && @next_ticket.call
        CallHistory.register(:ticket => @next_ticket, :wicket => @wicket)
        @next_ticket[:time] = I18n.localize(@next_ticket.updated_at, :format => :hour_minute)
        format.json { render :json => @next_ticket }
        format.html { redirect_to( place_wicket_tickets_url(params[:place_id], params[:wicket_id])) }
      else
        format.json { render :json => { :warning_message => I18n.t('model.no_tickets') }, :status => :no_content }
      end
    end
  end

  #POST places/1/wicket/1/recall
  def recall
    @ticket_recalled = Ticket.find(params[:ticket_id])
    @wicket = Wicket.find(params[:wicket_id])
    @ticket_recalled.current_wicket= @wicket
    respond_to do |format|
      if @ticket_recalled.recall
        CallHistory.register(:ticket => @ticket_recalled, :wicket => @wicket)
        format.html { redirect_to(place_wicket_tickets_url(params[:place_id], params[:wicket_id])) }
        format.json  { head :ok }
      end
    end
  end

  #PUT places/1/wicket/1/put_waiting
  def put_waiting
    @ticket_waiting = Ticket.find(params[:ticket_id])
    @wicket = Wicket.find(params[:wicket_id])
    respond_to do |format|
      if @ticket_waiting.pending
        CallHistory.register(:ticket => @ticket_waiting, :wicket => @wicket)
        @ticket_waiting[:time] = I18n.localize(@ticket_waiting.updated_at, :format => :hour_minute)
        format.html { redirect_to(place_wicket_tickets_url(params[:place_id], params[:wicket_id])) }
        format.json { render :json => @ticket_waiting }
      end
    end
  end
  #
  #PUT places/1/wicket/1/attend
  def attend
    @ticket_attended = Ticket.find(params[:ticket_id])
    @wicket = Wicket.find(params[:wicket_id])
    respond_to do |format|
      if @ticket_attended.attend
        CallHistory.register(:ticket => @ticket_attended, :wicket => @wicket)
        @ticket_attended[:time] = I18n.localize(@ticket_attended.updated_at, :format => :hour_minute)
        format.json { render :json => @ticket_attended }
        format.html { redirect_to(place_wicket_tickets_url(params[:place_id], params[:wicket_id])) }
      end
    end
  end

  #DELETE places/1/wicket/1/cancel
  def cancel
    @ticket_canceled = Ticket.find(params[:ticket_id])
    @wicket = Wicket.find(params[:wicket_id])
    respond_to do |format|
      if @ticket_canceled.cancel
        CallHistory.register(:ticket => @ticket_canceled, :wicket => @wicket)
        format.html { redirect_to(place_wicket_tickets_url(params[:place_id], params[:wicket_id])) }
        format.json { render :json => @ticket_canceled}
      end
    end
  end

  #PUT places/1/wicket/1/back_available
  def back_available
    @ticket = Ticket.find(params[:ticket_id])
    @wicket = Wicket.find(params[:wicket_id])
    respond_to do |format|
      if @ticket.reopen
          CallHistory.register(:ticket => @ticket, :wicket => @wicket)
          format.json { render :json => @ticket}
      end
    end
  end
end
