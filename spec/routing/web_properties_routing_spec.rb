require "spec_helper"

describe WebPropertiesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/web_properties" }.should route_to(:controller => "web_properties", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/web_properties/new" }.should route_to(:controller => "web_properties", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/web_properties/1" }.should route_to(:controller => "web_properties", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/web_properties/1/edit" }.should route_to(:controller => "web_properties", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/web_properties" }.should route_to(:controller => "web_properties", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/web_properties/1" }.should route_to(:controller => "web_properties", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/web_properties/1" }.should route_to(:controller => "web_properties", :action => "destroy", :id => "1")
    end

  end
end
