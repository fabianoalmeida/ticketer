class CallHistoriesController < ApplicationController
  # GET /call_histories
  # GET /call_histories.xml
  def index
    @call_histories = CallHistory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @call_histories }
    end
  end

  # GET /call_histories/1
  # GET /call_histories/1.xml
  def show
    @call_history = CallHistory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @call_history }
    end
  end

  # GET /call_histories/new
  # GET /call_histories/new.xml
  def new
    @call_history = CallHistory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @call_history }
    end
  end

  # GET /call_histories/1/edit
  def edit
    @call_history = CallHistory.find(params[:id])
  end

  # POST /call_histories
  # POST /call_histories.xml
  def create
    @call_history = CallHistory.new(params[:call_history])
    @call_history.call_history_type = CallHistoryType.called

    respond_to do |format|
      if @call_history.save
        format.html { redirect_to(@call_history, :notice => 'Call history was successfully created.') }
        format.xml  { render :xml => @call_history, :status => :created, :location => @call_history }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @call_history.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /call_histories/1
  # PUT /call_histories/1.xml
  def update
    @call_history = CallHistory.find(params[:id])

    respond_to do |format|
      if @call_history.update_attributes(params[:call_history])
        format.html { redirect_to(@call_history, :notice => 'Call history was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @call_history.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /call_histories/1
  # DELETE /call_histories/1.xml
  def destroy
    @call_history = CallHistory.find(params[:id])
    @call_history.destroy

    respond_to do |format|
      format.html { redirect_to(call_histories_url) }
      format.xml  { head :ok }
    end
  end
end
