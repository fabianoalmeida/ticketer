class GuidancesController < ApplicationController
  # GET /guidances
  # GET /guidances.xml
  def index
    @guidances = Guidance.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @guidances }
    end
  end

  # GET /guidances/1
  # GET /guidances/1.xml
  def show
    @guidance = Guidance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @guidance }
    end
  end

  # GET /guidances/new
  # GET /guidances/new.xml
  def new
    @guidance = Guidance.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @guidance }
    end
  end

  # GET /guidances/1/edit
  def edit
    @guidance = Guidance.find(params[:id])
  end

  # POST /guidances
  # POST /guidances.xml
  def create
    @guidance = Guidance.new(params[:guidance])

    respond_to do |format|
      if @guidance.save
        format.html { redirect_to(@guidance, :notice => 'Guidance was successfully created.') }
        format.xml  { render :xml => @guidance, :status => :created, :location => @guidance }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @guidance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /guidances/1
  # PUT /guidances/1.xml
  def update
    @guidance = Guidance.find(params[:id])

    respond_to do |format|
      if @guidance.update_attributes(params[:guidance])
        format.html { redirect_to(@guidance, :notice => 'Guidance was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @guidance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /guidances/1
  # DELETE /guidances/1.xml
  def destroy
    @guidance = Guidance.find(params[:id])
    @guidance.destroy

    respond_to do |format|
      format.html { redirect_to(guidances_url) }
      format.xml  { head :ok }
    end
  end
end
