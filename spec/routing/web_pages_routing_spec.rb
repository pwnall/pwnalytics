require "spec_helper"

describe WebPagesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/web_pages" }.should route_to(:controller => "web_pages", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/web_pages/new" }.should route_to(:controller => "web_pages", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/web_pages/1" }.should route_to(:controller => "web_pages", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/web_pages/1/edit" }.should route_to(:controller => "web_pages", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/web_pages" }.should route_to(:controller => "web_pages", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/web_pages/1" }.should route_to(:controller => "web_pages", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/web_pages/1" }.should route_to(:controller => "web_pages", :action => "destroy", :id => "1")
    end

  end
end
