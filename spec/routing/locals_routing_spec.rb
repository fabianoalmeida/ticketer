require "spec_helper"

describe LocalsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/locals" }.should route_to(:controller => "locals", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/locals/new" }.should route_to(:controller => "locals", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/locals/1" }.should route_to(:controller => "locals", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/locals/1/edit" }.should route_to(:controller => "locals", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/locals" }.should route_to(:controller => "locals", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/locals/1" }.should route_to(:controller => "locals", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/locals/1" }.should route_to(:controller => "locals", :action => "destroy", :id => "1")
    end

  end
end
