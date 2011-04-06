require "spec_helper"

describe StatusesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/statuses" }.should route_to(:controller => "statuses", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/statuses/new" }.should route_to(:controller => "statuses", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/statuses/1" }.should route_to(:controller => "statuses", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/statuses/1/edit" }.should route_to(:controller => "statuses", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/statuses" }.should route_to(:controller => "statuses", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/statuses/1" }.should route_to(:controller => "statuses", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/statuses/1" }.should route_to(:controller => "statuses", :action => "destroy", :id => "1")
    end

  end
end
