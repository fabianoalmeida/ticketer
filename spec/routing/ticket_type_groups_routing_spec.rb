require "spec_helper"

describe TicketTypeGroupsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/grupos_tipo_de_senha" }.should route_to(:controller => "ticket_type_groups", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/grupos_tipo_de_senha/novo" }.should route_to(:controller => "ticket_type_groups", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/grupos_tipo_de_senha/1" }.should route_to(:controller => "ticket_type_groups", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/grupos_tipo_de_senha/1/editar" }.should route_to(:controller => "ticket_type_groups", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/grupos_tipo_de_senha" }.should route_to(:controller => "ticket_type_groups", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/grupos_tipo_de_senha/1" }.should route_to(:controller => "ticket_type_groups", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/grupos_tipo_de_senha/1" }.should route_to(:controller => "ticket_type_groups", :action => "destroy", :id => "1")
    end

  end
end
