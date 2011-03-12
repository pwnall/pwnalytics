require "spec_helper"

describe EventsController do
  describe "routing" do
    it "recognizes and generates #new" do
      { :get => "/p.js" }.should route_to(:controller => "events", :action => "new", :format => "js")
    end

    it "recognizes and generates #create" do
      { :get => "/p.gif" }.should route_to(:controller => "events", :action => "create", :format => "gif")
    end

    it "recognizes and generates #index" do
      { :get => "/web_properties/2/events" }.should route_to(
          :controller => "events", :action => "index", :web_property_id => "2")
    end

    it "recognizes and generates #show" do
      { :get => "/web_properties/2/events/1" }.should route_to(
          :controller => "events", :action => "show", :id => "1",
          :web_property_id => "2")
    end
  end
end
