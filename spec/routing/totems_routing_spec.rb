require "spec_helper"

describe TotemsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/places/1/totems" }.should route_to(:place_id => "1", :controller => "totems", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/places/1/totems/new" }.should route_to(:place_id => "1", :controller => "totems", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/places/1/totems/1" }.should route_to(:place_id => "1", :controller => "totems", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/places/1/totems/1/edit" }.should route_to(:place_id => "1", :controller => "totems", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/places/1/totems" }.should route_to(:place_id => "1", :controller => "totems", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/places/1/totems/1" }.should route_to(:place_id => "1", :controller => "totems", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/places/1/totems/1" }.should route_to(:place_id => "1", :controller => "totems", :action => "destroy", :id => "1")
    end

  end
end
