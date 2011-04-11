class WicketsController < ApplicationController
  # GET /wickets
  # GET /wickets.xml
  def index
    @wickets = Wicket.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @wickets }
    end
  end

  # GET /wickets/1
  # GET /wickets/1.xml
  def show
    @wicket = Wicket.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @wicket }
    end
  end

  # GET /wickets/new
  # GET /wickets/new.xml
  def new
    @wicket = Wicket.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @wicket }
    end
  end

  # GET /wickets/1/edit
  def edit
    @wicket = Wicket.find(params[:id])
  end

  # POST /wickets
  # POST /wickets.xml
  def create
    @wicket = Wicket.new(params[:wicket])

    respond_to do |format|
      if @wicket.save
        format.html { redirect_to(@wicket, :notice => 'Wicket was successfully created.') }
        format.xml  { render :xml => @wicket, :status => :created, :location => @wicket }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @wicket.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /wickets/1
  # PUT /wickets/1.xml
  def update
    @wicket = Wicket.find(params[:id])

    respond_to do |format|
      if @wicket.update_attributes(params[:wicket])
        format.html { redirect_to(@wicket, :notice => 'Wicket was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wicket.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /wickets/1
  # DELETE /wickets/1.xml
  def destroy
    @wicket = Wicket.find(params[:id])
    @wicket.destroy

    respond_to do |format|
      format.html { redirect_to(wickets_url) }
      format.xml  { head :ok }
    end
  end
end