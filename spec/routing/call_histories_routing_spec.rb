require "spec_helper"

describe CallHistoriesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/call_histories" }.should route_to(:controller => "call_histories", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/call_histories/new" }.should route_to(:controller => "call_histories", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/call_histories/1" }.should route_to(:controller => "call_histories", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/call_histories/1/edit" }.should route_to(:controller => "call_histories", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/call_histories" }.should route_to(:controller => "call_histories", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/call_histories/1" }.should route_to(:controller => "call_histories", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/call_histories/1" }.should route_to(:controller => "call_histories", :action => "destroy", :id => "1")
    end

  end
end
