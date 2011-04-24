require "spec_helper"

describe GuidancesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/orientacoes" }.should route_to(:controller => "guidances", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/orientacoes/novo" }.should route_to(:controller => "guidances", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/orientacoes/1" }.should route_to(:controller => "guidances", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/orientacoes/1/editar" }.should route_to(:controller => "guidances", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/orientacoes" }.should route_to(:controller => "guidances", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/orientacoes/1" }.should route_to(:controller => "guidances", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/orientacoes/1" }.should route_to(:controller => "guidances", :action => "destroy", :id => "1")
    end

  end
end
