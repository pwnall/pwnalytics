require "spec_helper"

describe WebVisitorsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/web_visitors" }.should route_to(:controller => "web_visitors", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/web_visitors/new" }.should route_to(:controller => "web_visitors", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/web_visitors/1" }.should route_to(:controller => "web_visitors", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/web_visitors/1/edit" }.should route_to(:controller => "web_visitors", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/web_visitors" }.should route_to(:controller => "web_visitors", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/web_visitors/1" }.should route_to(:controller => "web_visitors", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/web_visitors/1" }.should route_to(:controller => "web_visitors", :action => "destroy", :id => "1")
    end

  end
end
