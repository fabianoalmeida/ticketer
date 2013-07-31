class PanelsController < ApplicationController
  def index
    @place = Place.find(params[:place_id])
    @panels = Panel.where(:place_id => @place.id).order(:value)
    respond_with(@panels)
  end

  def show
    @panel = Panel.find(params[:id])
    @place = Place.find(params[:place_id])
    respond_with(@panel)
  end

  def new
    @panel = Panel.new( :status => Status.active )
    @place = Place.find(params[:place_id])
    respond_with(@panel)
  end

  def edit
    @panel = Panel.find(params[:id])
    @place = Place.find(params[:place_id])
  end

  def create
    @panel = Panel.new(params[:panel])
    @place = Place.find(params[:place_id])
    @panel.user = "user test"
    flash[:notice] = "Panel was successfully created." if @panel.save
    respond_with(@panel, location: place_panel_url(@place, @panel))
  end

  def update
    @panel = Panel.find(params[:id])
    @place = Place.find(params[:place_id])
    flash[:notice] = "Panel was successfully updated." if @panel.update_attributes(params[:panel])
    respond_with(@panel, location: place_panel_url(@place, @panel))
  end

  def tickets
    @place = Place.find(params[:place_id])

    tickets_called = Ticket.calleds_from_place(@place.id).today.order('call_histories.updated_at DESC').take(7)
    @tickets_empty = tickets_called.empty?
    @second_column = []
    @first_column = []

    unless  @tickets_empty

      @main_ticket = tickets_called.first
      @last_wicket = CallHistory.last_wicket_to_call @main_ticket

      tickets_called = tickets_called.each_slice(3).to_a

      @first_column = tickets_called.first
      @second_column = tickets_called.second if tickets_called.second
    end

    render :layout => 'application-external'
  end
end
