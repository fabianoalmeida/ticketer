require "spec_helper"

describe PanelsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/places/1/panels" }.should route_to(:place_id => "1", :controller => "panels", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/places/1/panels/new" }.should route_to(:place_id => "1", :controller => "panels", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/places/1/panels/1" }.should route_to(:place_id => "1", :controller => "panels", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/places/1/panels/1/edit" }.should route_to(:place_id => "1", :controller => "panels", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/places/1/panels" }.should route_to(:place_id => "1", :controller => "panels", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/places/1/panels/1" }.should route_to(:place_id => "1", :controller => "panels", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/places/1/panels/1" }.should route_to(:place_id => "1", :controller => "panels", :action => "destroy", :id => "1")
    end

  end
end
