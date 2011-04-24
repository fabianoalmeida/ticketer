require "spec_helper"

describe PlacesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/localidades" }.should route_to(:controller => "places", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/localidades/novo" }.should route_to(:controller => "places", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/localidades/1" }.should route_to(:controller => "places", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/localidades/1/editar" }.should route_to(:controller => "places", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/localidades" }.should route_to(:controller => "places", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/localidades/1" }.should route_to(:controller => "places", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/localidades/1" }.should route_to(:controller => "places", :action => "destroy", :id => "1")
    end

  end
end
