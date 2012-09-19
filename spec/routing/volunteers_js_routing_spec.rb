require "spec_helper"

describe VolunteersJsController do
  describe "routing" do

    it "routes to #index" do
      get("/volunteers_js").should route_to("volunteers_js#index")
    end

    it "routes to #new" do
      get("/volunteers_js/new").should route_to("volunteers_js#new")
    end

    it "routes to #show" do
      get("/volunteers_js/1").should route_to("volunteers_js#show", :id => "1")
    end

    it "routes to #edit" do
      get("/volunteers_js/1/edit").should route_to("volunteers_js#edit", :id => "1")
    end

    it "routes to #create" do
      post("/volunteers_js").should route_to("volunteers_js#create")
    end

    it "routes to #update" do
      put("/volunteers_js/1").should route_to("volunteers_js#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/volunteers_js/1").should route_to("volunteers_js#destroy", :id => "1")
    end

  end
end
