class CallHistoriesController < ApplicationController
  # GET /call_histories
  # GET /call_histories.json
  def index
    @call_histories = CallHistory.today.order( "created_at DESC" )

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @call_histories }
    end
  end

  # GET /call_histories/1
  # GET /call_histories/1.json
  def show
    @call_history = CallHistory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @call_history }
    end
  end

  # GET /call_histories/new
  # GET /call_histories/new.json
  def new
    @call_history = CallHistory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @call_history }
    end
  end

  # GET /call_histories/1/edit
  def edit
    @call_history = CallHistory.find(params[:id])
  end

  # POST /call_histories
  # POST /call_histories.json
  def create
    @call_history = CallHistory.new(params[:call_history])

    respond_to do |format|
      if @call_history.save
        format.html { redirect_to(@call_history, :notice => 'Call history was successfully created.') }
        format.json  { render :json => @call_history, :status => :created, :location => @call_history }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @call_history.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /call_histories/1
  # PUT /call_histories/1.json
  def update
    @call_history = CallHistory.find(params[:id])

    respond_to do |format|
      if @call_history.update_attributes(params[:call_history])
        format.html { redirect_to(@call_history, :notice => 'Call history was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @call_history.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /call_histories/1
  # DELETE /call_histories/1.json
  def destroy
    @call_history = CallHistory.find(params[:id])
    @call_history.destroy

    respond_to do |format|
      format.html { redirect_to(call_histories_url) }
      format.json  { head :ok }
    end
  end
end
