class TotemsController < ApplicationController
  # GET /totems
  # GET /totems.xml
  def index
    @totems = Totem.all

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

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @totem }
    end
  end

  # GET /totems/1/edit
  def edit
    @totem = Totem.find(params[:id])
  end

  # POST /totems
  # POST /totems.xml
  def create
    @totem = Totem.new(params[:totem])

    respond_to do |format|
      if @totem.save
        format.html { redirect_to(@totem, :notice => 'Totem was successfully created.') }
        format.xml  { render :xml => @totem, :status => :created, :location => @totem }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @totem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /totems/1
  # PUT /totems/1.xml
  def update
    @totem = Totem.find(params[:id])

    respond_to do |format|
      if @totem.update_attributes(params[:totem])
        format.html { redirect_to(@totem, :notice => 'Totem was successfully updated.') }
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
    @totem.destroy

    respond_to do |format|
      format.html { redirect_to(totems_url) }
      format.xml  { head :ok }
    end
  end
end
