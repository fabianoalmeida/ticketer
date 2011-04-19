class ApplicationController < ActionController::Base
  
  #This solution looks like a kinda weird, should be improved it
  #before_filter RubyCAS::Filter, :unless => :require_been_loged?

  protect_from_forgery

  before_filter :set_locale

  private

  def set_locale
    I18n.locale = 'pt-BR'
  end

  def require_been_loged?
    false
  end  
end
