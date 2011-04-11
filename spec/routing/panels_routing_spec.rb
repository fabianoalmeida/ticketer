require "spec_helper"

describe PanelsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/panels" }.should route_to(:controller => "panels", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/panels/new" }.should route_to(:controller => "panels", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/panels/1" }.should route_to(:controller => "panels", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/panels/1/edit" }.should route_to(:controller => "panels", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/panels" }.should route_to(:controller => "panels", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/panels/1" }.should route_to(:controller => "panels", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/panels/1" }.should route_to(:controller => "panels", :action => "destroy", :id => "1")
    end

  end
end
