require "spec_helper"

describe WebPagesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/web_properties/2/web_pages" }.should route_to(
          :controller => "web_pages", :action => "index",
          :web_property_id => "2")
    end

    it "recognizes and generates #show" do
      { :get => "/web_properties/2/web_pages/1" }.should route_to(
          :controller => "web_pages", :action => "show", :id => "1",
          :web_property_id => "2")
    end
  end
end
