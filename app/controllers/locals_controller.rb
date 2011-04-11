class LocalsController < ApplicationController
  # GET /locals
  # GET /locals.xml
  def index
    @locals = Local.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @locals }
    end
  end

  # GET /locals/1
  # GET /locals/1.xml
  def show
    @local = Local.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @local }
    end
  end

  # GET /locals/new
  # GET /locals/new.xml
  def new
    @local = Local.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @local }
    end
  end

  # GET /locals/1/edit
  def edit
    @local = Local.find(params[:id])
  end

  # POST /locals
  # POST /locals.xml
  def create
    @local = Local.new(params[:local])

    respond_to do |format|
      if @local.save
        format.html { redirect_to(@local, :notice => 'Local was successfully created.') }
        format.xml  { render :xml => @local, :status => :created, :location => @local }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @local.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /locals/1
  # PUT /locals/1.xml
  def update
    @local = Local.find(params[:id])

    respond_to do |format|
      if @local.update_attributes(params[:local])
        format.html { redirect_to(@local, :notice => 'Local was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @local.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /locals/1
  # DELETE /locals/1.xml
  def destroy
    @local = Local.find(params[:id])
    @local.destroy

    respond_to do |format|
      format.html { redirect_to(locals_url) }
      format.xml  { head :ok }
    end
  end
end
