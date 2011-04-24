require "spec_helper"

describe TicketsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/senhas" }.should route_to(:controller => "tickets", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/senhas/novo" }.should route_to(:controller => "tickets", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/senhas/1" }.should route_to(:controller => "tickets", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/senhas/1/editar" }.should route_to(:controller => "tickets", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/senhas" }.should route_to(:controller => "tickets", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/senhas/1" }.should route_to(:controller => "tickets", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/senhas/1" }.should route_to(:controller => "tickets", :action => "destroy", :id => "1")
    end

  end
end
