class TotemsController < ApplicationController
  prepend_before_filter :generate_ticket_must_pass, :only => :generate_ticket

  # GET /totems
  # GET /totems.xml
  def index
    @totems = Totem.where(:place_id => params[:place_id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @totems }
    end
  end

  # GET /totems/1
  # GET /totems/1.xml
  def show
    @totem = Totem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @totem }
    end
  end

  # GET /totems/new
  # GET /totems/new.xml
  def new
    @totem = Totem.new
    @place = Place.find(params[:place_id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @totem }
    end
  end

  # GET /totems/1/edit
  def edit
    @totem = Totem.find(params[:id])
    @place = Place.find(params[:place_id])
  end

  # POST /totems
  # POST /totems.xml
  def create
    @totem = Totem.new(params[:totem])
    @place = Place.find(params[:place_id])
    @totem.user = "user test"

    respond_to do |format|
      if @totem.save
        format.html { redirect_to(place_totem_url(@place, @totem), :notice => 'Totem was successfully created.') }
        format.xml  { render :xml => @totem, :status => :created, :location => @totem }
      else
        format.html { render :action => :new }
        format.xml  { render :xml => @totem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /totems/1
  # PUT /totems/1.xml
  def update
    @totem = Totem.find(params[:id])
    @place = Place.find(params[:place_id])

    respond_to do |format|
      if @totem.update_attributes(params[:totem])
        format.html { redirect_to(place_totem_url(@place, @totem), :notice => 'Totem was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @totem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /totems/1
  # DELETE /totems/1.xml
  def destroy
    @totem = Totem.find(params[:id])
    @place = Place.find(params[:place_id])
    @totem.destroy

    respond_to do |format|
      format.html { redirect_to(place_totems_url(@place)) }
      format.xml  { head :ok }
    end
  end

  # GET /generate_ticket
  def generate_ticket
    @place = Place.where(:id => params[:place_id]).first
    @ticket_types = @place.ticket_types

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ticket_types }
    end
  end

  private 
  def generate_ticket_must_pass
    @it_is_required = true
  end
  def require_been_loged?
    @it_is_required
  end
end
