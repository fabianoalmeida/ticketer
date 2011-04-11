require "spec_helper"

describe TotemsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/totems" }.should route_to(:controller => "totems", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/totems/new" }.should route_to(:controller => "totems", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/totems/1" }.should route_to(:controller => "totems", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/totems/1/edit" }.should route_to(:controller => "totems", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/totems" }.should route_to(:controller => "totems", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/totems/1" }.should route_to(:controller => "totems", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/totems/1" }.should route_to(:controller => "totems", :action => "destroy", :id => "1")
    end

  end
end
