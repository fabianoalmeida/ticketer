require "spec_helper"

describe TicketTypesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/tipos_de_senha" }.should route_to(:controller => "ticket_types", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/tipos_de_senha/novo" }.should route_to(:controller => "ticket_types", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/tipos_de_senha/1" }.should route_to(:controller => "ticket_types", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/tipos_de_senha/1/editar" }.should route_to(:controller => "ticket_types", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/tipos_de_senha" }.should route_to(:controller => "ticket_types", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/tipos_de_senha/1" }.should route_to(:controller => "ticket_types", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/tipos_de_senha/1" }.should route_to(:controller => "ticket_types", :action => "destroy", :id => "1")
    end

  end
end
