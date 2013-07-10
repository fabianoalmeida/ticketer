class TotemsController < ApplicationController
  prepend_before_filter :generate_ticket_must_pass, :only => :generate_ticket

  def index
    @place = Place.find(params[:place_id])
    @totems = Totem.where(:place_id => @place.id).order( "value ASC" )
    respond_with(@totems)
  end

  def show
    @totem = Totem.find(params[:id])
    @place = Place.find(params[:place_id])
    respond_with(@totem)
  end

  def new
    @totem = Totem.new( :status => Status.active )
    @place = Place.find(params[:place_id])
    @printers = Printer.order(:name)
    respond_with(@totem)
  end

  def edit
    @totem = Totem.find(params[:id])
    @place = Place.find(params[:place_id])
    @printers = Printer.order(:name)
  end

  def create
    @totem = Totem.new(params[:totem])
    @place = Place.find(params[:place_id])
    @totem.user = "user test"
    flash[:notice] = 'Totem was successfully created.' if @totem.save
    respond_with(@totem, location: place_totem_url(@place, @totem))
  end

  def update
    @totem = Totem.find(params[:id])
    @place = Place.find(params[:place_id])
    flash[:notice] = 'Totem was successfully updated.' if @totem.update_attributes(params[:totem])
    respond_with(@totem, location: place_totem_url(@place, @totem))
  end

  def generate_ticket
    @place = Place.find(params[:place_id])
    @ticket_type_groups = @place.ticket_type_groups.order(:value)
    respond_with(@ticket_type_groups) do |format|
      format.html { render :layout => 'application-totem' }
    end
  end

  def ticket_type_groups
    @place = Place.find(params[:place_id])
    @ticket_type_groups = @place.ticket_type_groups.order(:value)
    respond_with(@ticket_type_groups) do |format|
      format.html { render :layout => 'application-totem' }
    end
  end

  private

  #Necessary to CAS authentication bypass
  def generate_ticket_must_pass
    @it_is_required = true
  end
  def require_been_loged?
    @it_is_required
  end
end
