class CallHistoryTypesController < ApplicationController
  # GET /call_history_types
  # GET /call_history_types.json
  def index
    @call_history_types = CallHistoryType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @call_history_types }
    end
  end

  # GET /call_history_types/1
  # GET /call_history_types/1.json
  def show
    @call_history_type = CallHistoryType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @call_history_type }
    end
  end

  # GET /call_history_types/new
  # GET /call_history_types/new.json
  def new
    @call_history_type = CallHistoryType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @call_history_type }
    end
  end

  # GET /call_history_types/1/edit
  def edit
    @call_history_type = CallHistoryType.find(params[:id])
  end

  # POST /call_history_types
  # POST /call_history_types.json
  def create
    @call_history_type = CallHistoryType.new(params[:call_history_type])
    @call_history_type.user= "user test"

    respond_to do |format|
      if @call_history_type.save
        format.html { redirect_to(@call_history_type, :notice => 'Call history type was successfully created.') }
        format.json  { render :json => @call_history_type, :status => :created, :location => @call_history_type }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @call_history_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /call_history_types/1
  # PUT /call_history_types/1.json
  def update
    @call_history_type = CallHistoryType.find(params[:id])

    respond_to do |format|
      if @call_history_type.update_attributes(params[:call_history_type])
        format.html { redirect_to(@call_history_type, :notice => 'Call history type was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @call_history_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /call_history_types/1
  # DELETE /call_history_types/1.json
  def destroy
    @call_history_type = CallHistoryType.find(params[:id])
    @call_history_type.destroy

    respond_to do |format|
      format.html { redirect_to(call_history_types_url) }
      format.json  { head :ok }
    end
  end
end
