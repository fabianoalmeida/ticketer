class PlacesController < ApplicationController
  def index
    @places = Place.order(:value)
    respond_with(@places)
  end

  def show
    @place = Place.find(params[:id])
    @locals = Local.all
    @ticket_type_groups = TicketTypeGroup.order(:value)
    @statuses = Status.order(:value)
    respond_with(@places)
  end

  def new
    @place = Place.new( :status => Status.active )
    @locals = Local.all
    @ticket_type_groups = TicketTypeGroup.order(:value)
    @statuses = Status.order(:value)
    respond_with(@places)
  end

  def edit
    @place = Place.find(params[:id])
    @locals = Local.all
    @ticket_type_groups = TicketTypeGroup.order(:value)
    @statuses = Status.order(:value)
  end

  def create
    @place = Place.new(params[:place])
    @place.user= "user test"
    @locals = Local.all
    flash[:notice] = "Place was successfully created." if @place.save
    respond_with(@place)
  end

  def update
    @place = Place.find(params[:id])
    @locals = Local.all
    flash[:notice] = "Place was successfully updated." if @place.update_attributes(params[:place])
    respond_with(@place)
  end

  def home
    @place = Place.find(params[:place_id])
    @wickets = @place.wickets.where(:status_id => Status.active.id).order(:value)
    render :layout => 'places'
  end
end
