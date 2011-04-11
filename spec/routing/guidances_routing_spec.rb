require "spec_helper"

describe GuidancesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/guidances" }.should route_to(:controller => "guidances", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/guidances/new" }.should route_to(:controller => "guidances", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/guidances/1" }.should route_to(:controller => "guidances", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/guidances/1/edit" }.should route_to(:controller => "guidances", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/guidances" }.should route_to(:controller => "guidances", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/guidances/1" }.should route_to(:controller => "guidances", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/guidances/1" }.should route_to(:controller => "guidances", :action => "destroy", :id => "1")
    end

  end
end
