class ApplicationController < ActionController::Base

  helper :all

  protect_from_forgery

  before_filter :set_locale

  private

  def set_locale
    I18n.locale = 'pt-BR'
  end
end
