require "spec_helper"

describe TicketTypesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/ticket_types" }.should route_to(:controller => "ticket_types", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/ticket_types/new" }.should route_to(:controller => "ticket_types", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/ticket_types/1" }.should route_to(:controller => "ticket_types", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/ticket_types/1/edit" }.should route_to(:controller => "ticket_types", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/ticket_types" }.should route_to(:controller => "ticket_types", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/ticket_types/1" }.should route_to(:controller => "ticket_types", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/ticket_types/1" }.should route_to(:controller => "ticket_types", :action => "destroy", :id => "1")
    end

  end
end
