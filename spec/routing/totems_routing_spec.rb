require "spec_helper"

describe TotemsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/localidades/1/totems" }.should route_to(:place_id => "1", :controller => "totems", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/localidades/1/totems/novo" }.should route_to(:place_id => "1", :controller => "totems", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/localidades/1/totems/1" }.should route_to(:place_id => "1", :controller => "totems", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/localidades/1/totems/1/editar" }.should route_to(:place_id => "1", :controller => "totems", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/localidades/1/totems" }.should route_to(:place_id => "1", :controller => "totems", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/localidades/1/totems/1" }.should route_to(:place_id => "1", :controller => "totems", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/localidades/1/totems/1" }.should route_to(:place_id => "1", :controller => "totems", :action => "destroy", :id => "1")
    end

  end
end
