require "spec_helper"

describe StatusTicketsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/status_de_senha" }.should route_to(:controller => "status_tickets", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/status_de_senha/novo" }.should route_to(:controller => "status_tickets", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/status_de_senha/1" }.should route_to(:controller => "status_tickets", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/status_de_senha/1/editar" }.should route_to(:controller => "status_tickets", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/status_de_senha" }.should route_to(:controller => "status_tickets", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/status_de_senha/1" }.should route_to(:controller => "status_tickets", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/status_de_senha/1" }.should route_to(:controller => "status_tickets", :action => "destroy", :id => "1")
    end

  end
end
