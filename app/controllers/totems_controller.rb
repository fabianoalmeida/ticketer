class TotemsController < ApplicationController
  prepend_before_filter :generate_ticket_must_pass, :only => :generate_ticket

  # GET /totems
  # GET /totems.json
  def index
    @totems = Totem.where(:place_id => params[:place_id], :status_id => Status.active)

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @totems }
    end
  end

  # GET /totems/1
  # GET /totems/1.json
  def show
    @totem = Totem.find(params[:id])
    @place = Place.find(params[:place_id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @totem }
    end
  end

  # GET /totems/new
  # GET /totems/new.json
  def new
    @totem = Totem.new
    @place = Place.find(params[:place_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @totem }
    end
  end

  # GET /totems/1/edit
  def edit
    @totem = Totem.find(params[:id])
    @place = Place.find(params[:place_id])
  end

  # POST /totems
  # POST /totems.json
  def create
    @totem = Totem.new(params[:totem])
    @place = Place.find(params[:place_id])
    @totem.user = "user test"

    respond_to do |format|
      if @totem.save
        format.html { redirect_to(place_totem_url(@place, @totem), :notice => 'Totem was successfully created.') }
        format.json  { render :json => @totem, :status => :created, :location => @totem }
      else
        format.html { render :action => :new }
        format.json  { render :json => @totem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /totems/1
  # PUT /totems/1.json
  def update
    @totem = Totem.find(params[:id])
    @place = Place.find(params[:place_id])

    respond_to do |format|
      if @totem.update_attributes(params[:totem])
        format.html { redirect_to(place_totem_url(@place, @totem), :notice => 'Totem was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @totem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /totems/1
  # DELETE /totems/1.json
  def destroy
    @place = Place.find(params[:place_id])
    @totem = Totem.find(params[:id])
    @totem.status = Status.inactive
    @totem.save

    respond_to do |format|
      format.html { redirect_to(place_totems_url(@place)) }
      format.json  { head :ok }
    end
  end

  # GET /generate_ticket
  def generate_ticket
    @ticket = Ticket.new
    @place = Place.find(params[:place_id])
    @ticket_type_groups = @place.ticket_type_groups

    respond_to do |format|
      format.html {render :layout => 'application-totem'}
      format.json  { render :json => @ticket_type_groups }
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
