require "spec_helper"

describe WicketsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/localidades/1/guiches" }.should route_to(:place_id => "1", :controller => "wickets", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/localidades/1/guiches/novo" }.should route_to(:place_id => "1", :controller => "wickets", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/localidades/1/guiches/1" }.should route_to(:place_id => "1", :controller => "wickets", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/localidades/1/guiches/1/editar" }.should route_to(:place_id => "1", :controller => "wickets", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/localidades/1/guiches" }.should route_to(:place_id => "1", :controller => "wickets", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/localidades/1/guiches/1" }.should route_to(:place_id => "1", :controller => "wickets", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/localidades/1/guiches/1" }.should route_to(:place_id => "1", :controller => "wickets", :action => "destroy", :id => "1")
    end

    it "recognizes and generates #call_next" do
      { :post => "/localidades/1/guiches/1/chamar_proximo" }.should route_to(:place_id => "1", :controller => "wickets", :action => "call_next", :wicket_id => "1")
    end

    it "recognizes and generates #recall" do
      { :post => "/localidades/1/guiches/1/rechamar" }.should route_to(:place_id => "1", :controller => "wickets", :action => "recall", :wicket_id => "1")
    end
  end
end
