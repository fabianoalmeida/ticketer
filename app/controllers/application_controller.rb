require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :json, :js, :xml, :html


  #This solution looks like a kinda weird, should be improved it
  #before_filter RubyCAS::Filter, :unless => :require_been_loged?


  protect_from_forgery

  private

  def require_been_loged?
    false
  end
end
