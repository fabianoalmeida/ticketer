class PanelsController < ApplicationController
  # GET /panels
  # GET /panels.json
  def index
    @place = Place.find(params[:place_id])
    @panels = Panel.where(:place_id => @place.id).order( "value ASC" )

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @panels }
    end
  end

  # GET /panels/1
  # GET /panels/1.json
  def show
    @panel = Panel.find(params[:id])
    @place = Place.find(params[:place_id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @panel }
    end
  end

  # GET /panels/new
  # GET /panels/new.json
  def new
    @panel = Panel.new( :status => Status.active )
    @place = Place.find(params[:place_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @panel }
    end
  end

  # GET /panels/1/edit
  def edit
    @panel = Panel.find(params[:id])
    @place = Place.find(params[:place_id])
  end

  # POST /panels
  # POST /panels.json
  def create
    @panel = Panel.new(params[:panel])
    @place = Place.find(params[:place_id])
    @panel.user = "user test"

    respond_to do |format|
      if @panel.save
        format.html { redirect_to(place_panel_url(@place, @panel), :notice => 'Panel was successfully created.') }
        format.json  { render :json => @panel, :status => :created, :location => @panel }
      else
        format.html { render :action => :new }
        format.json  { render :json => @panel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /panels/1
  # PUT /panels/1.json
  def update
    @panel = Panel.find(params[:id])
    @place = Place.find(params[:place_id])

    respond_to do |format|
      if @panel.update_attributes(params[:panel])
        format.html { redirect_to(place_panel_url(@place, @panel), :notice => 'Panel was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @panel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /panels/1
  # DELETE /panels/1.json
  def destroy
    @place = Place.find(params[:place_id])
    @panel = Panel.find(params[:id])
    @panel.status = Status.inactive
    @panel.save

    respond_to do |format|
      format.html { redirect_to(place_panels_url(@place)) }
      format.json  { head :ok }
    end
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
