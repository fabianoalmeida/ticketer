require "spec_helper"

describe CallHistoryTypesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/call_history_types" }.should route_to(:controller => "call_history_types", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/call_history_types/new" }.should route_to(:controller => "call_history_types", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/call_history_types/1" }.should route_to(:controller => "call_history_types", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/call_history_types/1/edit" }.should route_to(:controller => "call_history_types", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/call_history_types" }.should route_to(:controller => "call_history_types", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/call_history_types/1" }.should route_to(:controller => "call_history_types", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/call_history_types/1" }.should route_to(:controller => "call_history_types", :action => "destroy", :id => "1")
    end

  end
end
