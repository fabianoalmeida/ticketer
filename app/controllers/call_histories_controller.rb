class CallHistoriesController < ApplicationController
  def index
    @call_histories = CallHistory.today.order( "created_at DESC" )
    respond_with(@call_histories)
  end
end
