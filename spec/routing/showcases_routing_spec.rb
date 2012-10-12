require "spec_helper"

describe ShowcasesController do
  describe "routing" do

    it "routes to #index" do
      get("/showcases").should route_to("showcases#index")
    end

    it "routes to #new" do
      get("/showcases/new").should route_to("showcases#new")
    end

    it "routes to #show" do
      get("/showcases/1").should route_to("showcases#show", :id => "1")
    end

    it "routes to #edit" do
      get("/showcases/1/edit").should route_to("showcases#edit", :id => "1")
    end

    it "routes to #create" do
      post("/showcases").should route_to("showcases#create")
    end

    it "routes to #update" do
      put("/showcases/1").should route_to("showcases#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/showcases/1").should route_to("showcases#destroy", :id => "1")
    end

  end
end
