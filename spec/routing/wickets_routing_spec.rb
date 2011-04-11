require "spec_helper"

describe WicketsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/wickets" }.should route_to(:controller => "wickets", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/wickets/new" }.should route_to(:controller => "wickets", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/wickets/1" }.should route_to(:controller => "wickets", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/wickets/1/edit" }.should route_to(:controller => "wickets", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/wickets" }.should route_to(:controller => "wickets", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/wickets/1" }.should route_to(:controller => "wickets", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/wickets/1" }.should route_to(:controller => "wickets", :action => "destroy", :id => "1")
    end

  end
end
