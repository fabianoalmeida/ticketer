class ApplicationController < ActionController::Base
  
  #This solution looks like a kinda weird, should be improved it
  #before_filter RubyCAS::Filter, :unless => :require_been_loged?


  protect_from_forgery

  private

  def require_been_loged?
    false
  end  
end
