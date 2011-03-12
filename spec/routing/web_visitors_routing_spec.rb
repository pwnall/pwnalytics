require "spec_helper"

describe WebVisitorsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/web_properties/2/web_visitors" }.should route_to(
          :controller => "web_visitors", :action => "index",
          :web_property_id => "2")
    end

    it "recognizes and generates #show" do
      { :get => "/web_properties/2/web_visitors/1" }.should route_to(
          :controller => "web_visitors", :action => "show", :id => "1",
          :web_property_id => "2")
    end
  end
end
