class WicketsController < ApplicationController
  # GET /wickets
  # GET /wickets.json
  def index
    @wickets = Wicket.where(:place_id => params[:place_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @wickets }
    end
  end

  # GET /wickets/1
  # GET /wickets/1.json
  def show
    @wicket = Wicket.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @wicket }
    end
  end

  # GET /wickets/new
  # GET /wickets/new.json
  def new
    @wicket = Wicket.new
    @place = Place.find(params[:place_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @wicket }
    end
  end

  # GET /wickets/1/edit
  def edit
    @wicket = Wicket.find(params[:id])
    @place = Place.find(params[:place_id])
  end

  # POST /wickets
  # POST /wickets.json
  def create
    @wicket = Wicket.new(params[:wicket])
    @place = Place.find(params[:place_id])
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
    @wicket = Wicket.find(params[:id])
    @place = Place.find(params[:place_id])
    @wicket.destroy

    respond_to do |format|
      format.html { redirect_to(place_wickets_url(@place)) }
      format.json  { head :ok }
    end
  end

  # GET /wicket/1/tickets
  def tickets
    @wicket = Wicket.find(params[:wicket_id])
    @place =  Place.find(params[:place_id])
    @tickets_type = @place.ticket_types  
    @tickets =@place.tickets_availables.today
    @tickets_called = @wicket.called_tickets.today 
    @tickets_waiting = @wicket.pending_tickets.today
  end

  #POST places/1/wicket/1/call_next
  def call_next
    @next_ticket = Ticket.next_to(params[:place_id])
    @wicket = Wicket.find(params[:wicket_id])
    @next_ticket.current_wicket= @wicket if @next_ticket
    respond_to do |format|
      if @next_ticket && @next_ticket.call
        CallHistory.register(:ticket => @next_ticket, :wicket => @wicket)
        format.html { redirect_to(place_wicket_tickets_url(params[:place_id], params[:wicket_id])) }
        format.json { render :json => @next_ticket }
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
        format.html { redirect_to(place_wicket_tickets_url(params[:place_id], params[:wicket_id])) }
        format.json { render :json => @ticket_waiting }
      end 
    end
  end
  #
  #POST places/1/wicket/1/attend
  def attend
    @ticket_attended = Ticket.find(params[:ticket_id]) 
    @wicket = Wicket.find(params[:wicket_id])
    respond_to do |format|
      if @ticket_attended.attend 
        CallHistory.register(:ticket => @ticket_attended, :wicket => @wicket)
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
        CallHistory.register(:ticket => @ticket_waiting, :wicket => @wicket)
        format.html { redirect_to(place_wicket_tickets_url(params[:place_id], params[:wicket_id])) }
      end
    end
  end
end
