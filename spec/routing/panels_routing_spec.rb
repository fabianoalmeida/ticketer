require "spec_helper"

describe PanelsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/localidades/1/paineis" }.should route_to(:place_id => "1", :controller => "panels", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/localidades/1/paineis/novo" }.should route_to(:place_id => "1", :controller => "panels", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/localidades/1/paineis/1" }.should route_to(:place_id => "1", :controller => "panels", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/localidades/1/paineis/1/editar" }.should route_to(:place_id => "1", :controller => "panels", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/localidades/1/paineis" }.should route_to(:place_id => "1", :controller => "panels", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/localidades/1/paineis/1" }.should route_to(:place_id => "1", :controller => "panels", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/localidades/1/paineis/1" }.should route_to(:place_id => "1", :controller => "panels", :action => "destroy", :id => "1")
    end

  end
end
