require "spec_helper"

describe LocalsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/locais" }.should route_to(:controller => "locals", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/locais/novo" }.should route_to(:controller => "locals", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/locais/1" }.should route_to(:controller => "locals", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/locais/1/editar" }.should route_to(:controller => "locals", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/locais" }.should route_to(:controller => "locals", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/locais/1" }.should route_to(:controller => "locals", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/locais/1" }.should route_to(:controller => "locals", :action => "destroy", :id => "1")
    end

  end
end
