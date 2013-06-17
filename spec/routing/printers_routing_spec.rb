require "spec_helper"

describe PrintersController do
  describe "routing" do

    it "routes to #index" do
      get("/printers").should route_to("printers#index")
    end

    it "routes to #new" do
      get("/printers/new").should route_to("printers#new")
    end

    it "routes to #show" do
      get("/printers/1").should route_to("printers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/printers/1/edit").should route_to("printers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/printers").should route_to("printers#create")
    end

    it "routes to #update" do
      put("/printers/1").should route_to("printers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/printers/1").should route_to("printers#destroy", :id => "1")
    end

  end
end
