require "spec_helper"

describe CallHistoriesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/historico_de_chamadas" }.should route_to(:controller => "call_histories", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/historico_de_chamadas/novo" }.should route_to(:controller => "call_histories", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/historico_de_chamadas/1" }.should route_to(:controller => "call_histories", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/historico_de_chamadas/1/editar" }.should route_to(:controller => "call_histories", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/historico_de_chamadas" }.should route_to(:controller => "call_histories", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/historico_de_chamadas/1" }.should route_to(:controller => "call_histories", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/historico_de_chamadas/1" }.should route_to(:controller => "call_histories", :action => "destroy", :id => "1")
    end

  end
end
