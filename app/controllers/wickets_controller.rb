class WicketsController < ApplicationController
  def index
    @place = Place.find(params[:place_id])
    @wickets = Wicket.where(:place_id => @place.id).order(:value)
    respond_with(@wickets)
  end

  def show
    @wicket = Wicket.find(params[:id])
    @place = Place.find(params[:place_id])
    @ticket_type_groups = @place.ticket_type_groups.order(:value)
    @reference_groups = @place.ticket_type_groups.order(:value)
    respond_with(@wicket)
  end

  def new
    @wicket = Wicket.new( :priority => false, :status => Status.active )
    @place = Place.find(params[:place_id])
    @ticket_type_groups = @place.ticket_type_groups.order(:value)
    @reference_groups = @place.ticket_type_groups.order(:value)
    respond_with(@wicket)
  end

  def edit
    @wicket = Wicket.find(params[:id])
    @place = Place.find(params[:place_id])
    @ticket_type_groups = @place.ticket_type_groups.order(:value)
    @reference_groups = @place.ticket_type_groups.order(:value)
  end

  def create
    @wicket = Wicket.new(params[:wicket])
    @place = Place.find(params[:place_id])
    @ticket_type_groups = @place.ticket_type_groups.order(:value)
    @reference_groups = @place.ticket_type_groups.order(:value)
    @wicket.user= "user test"
    flash[:notice] = 'Wicket was successfully created.' if @wicket.save
    respond_with(@wicket, location: place_wicket_url(@place, @wicket))
  end

  def update
    @wicket = Wicket.find(params[:id])
    @place = Place.find(params[:place_id])
    @ticket_type_groups = @wicket.ticket_type_groups.order(:value)
    @reference_groups = @wicket.ticket_type_groups.order(:value)
    flash[:notice] = 'Wicket was successfully updated.' if @wicket.update_attributes(params[:wicket])
    respond_with(@wicket, location: place_wicket_url(@place, @wicket))
  end

  def tickets
    @wicket = Wicket.find(params[:wicket_id])
    @place =  Place.find(params[:place_id])

    @tickets_type= []
    @ticket_type_groups_id= []

    @wicket.ticket_type_groups.each do |ticket_type_group|
      @tickets_type << ticket_type_group.ticket_types
      @ticket_type_groups_id << ticket_type_group.id
    end

    @tickets_type= @tickets_type.flatten

    unless @wicket.second_level?
      @tickets_available = @place.tickets_availables(@wicket.ticket_type_groups).today
      @tickets_attended  = @wicket.attended_tickets.today
      @tickets_called    = @wicket.called_tickets.today
      @tickets_waiting   = @wicket.pending_tickets.today
    else
      @tickets_attended  = @place.tickets_attended(@wicket.ticket_type_groups).today
      @tickets_examed    = @wicket.examed_tickets.today
      @tickets_called    = []
      @tickets_waiting   = []
    end

    if @wicket.priority
      @tickets_available = @tickets_available.sort do |a, b|
        (a.ticket_type.priority == b.ticket_type.priority) ? ((a.created_at < b.created_at) ? -1 : 1) : (a.ticket_type.priority ? -1 : 1)
      end
    end

    render :layout => 'application-external'
  end

  def call_next
    @wicket = Wicket.find(params[:wicket_id])
    @next_ticket = Ticket.next_to(@wicket)
    @next_ticket.current_wicket= @wicket if @next_ticket
    if @next_ticket && @next_ticket.call
      CallHistory.register(ticket: @next_ticket, wicket: @wicket)
      @next_ticket[:time] = I18n.localize(@next_ticket.updated_at, format: :hour_minute)
      respond_with(@wicket, location: place_wicket_tickets_url(params[:place_id], @wicket))
    else
      respond_to do |format|
        format.json { render json: { warning_message: I18n.t('model.no_tickets') }, status: :no_content }
      end
    end
  end

  def call_ticket
    @wicket = Wicket.find(params[:wicket_id])
    @ticket = Ticket.find(params[:ticket_id])
    @ticket.current_wicket= @wicket if @ticket && @ticket.available?
    if @ticket.available? && @ticket.call
      CallHistory.register(ticket: @ticket, wicket: @wicket)
      @ticket[:time] = I18n.localize(@ticket.updated_at, format: :hour_minute)
      respond_with(@ticket, location: place_wicket_tickets_url(params[:place_id], @wicket))
    else
      respond_to do |format|
        format.json { render json: { warning_message: I18n.t('model.no_tickets') }, status: :no_content }
      end
    end
  end

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

  def attend
    @ticket_attended = Ticket.find(params[:ticket_id])
    @wicket = Wicket.find(params[:wicket_id])
    respond_to do |format|
      unless @ticket_attended.attended?
        if @ticket_attended.attend
          CallHistory.register(:ticket => @ticket_attended, :wicket => @wicket)
          @ticket_attended[:time] = I18n.localize(@ticket_attended.updated_at, :format => :hour_minute)
          format.json { render :json => @ticket_attended }
          format.html { redirect_to(place_wicket_tickets_url(params[:place_id], params[:wicket_id])) }
        end
      end
    end
  end

  def examine
    @ticket_attended = Ticket.find(params[:ticket_id])
    @wicket = Wicket.find(params[:wicket_id])
    respond_to do |format|
      unless @ticket_attended.examed?
        if @ticket_attended.exam
          CallHistory.register(:ticket => @ticket_attended, :wicket => @wicket)
          @ticket_attended[:time] = I18n.localize(@ticket_attended.updated_at, :format => :hour_minute)
          format.json { render :json => @ticket_attended }
          format.html { redirect_to(place_wicket_tickets_url(params[:place_id], params[:wicket_id])) }
        end
      end
    end
  end

  def cancel
    @ticket_canceled = Ticket.find(params[:ticket_id])
    @wicket = Wicket.find(params[:wicket_id])
    respond_to do |format|
      unless @ticket_canceled.canceled?
        if @ticket_canceled.cancel
          CallHistory.register(:ticket => @ticket_canceled, :wicket => @wicket)
          format.html { redirect_to(place_wicket_tickets_url(params[:place_id], params[:wicket_id])) }
          format.json { render :json => @ticket_canceled}
        end
      end
    end
  end

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
