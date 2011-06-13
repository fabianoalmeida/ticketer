require "spec_helper"

describe TicketTypeGroupsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/ticket_type_groups" }.should route_to(:controller => "ticket_type_groups", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/ticket_type_groups/new" }.should route_to(:controller => "ticket_type_groups", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/ticket_type_groups/1" }.should route_to(:controller => "ticket_type_groups", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/ticket_type_groups/1/edit" }.should route_to(:controller => "ticket_type_groups", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/ticket_type_groups" }.should route_to(:controller => "ticket_type_groups", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/ticket_type_groups/1" }.should route_to(:controller => "ticket_type_groups", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/ticket_type_groups/1" }.should route_to(:controller => "ticket_type_groups", :action => "destroy", :id => "1")
    end

  end
end
