class HomeController < ApplicationController

  def index
    @places = Place.actives
    render :layout => 'home'
  end

  def main
    render :layout => 'home'
  end

end
