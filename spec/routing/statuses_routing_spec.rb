require "spec_helper"

describe StatusesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/status" }.should route_to(:controller => "statuses", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/status/novo" }.should route_to(:controller => "statuses", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/status/1" }.should route_to(:controller => "statuses", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/status/1/editar" }.should route_to(:controller => "statuses", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/status" }.should route_to(:controller => "statuses", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/status/1" }.should route_to(:controller => "statuses", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/status/1" }.should route_to(:controller => "statuses", :action => "destroy", :id => "1")
    end

  end
end
