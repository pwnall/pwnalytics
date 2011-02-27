require "spec_helper"

describe WebVisitorsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/web_visitors" }.should route_to(:controller => "web_visitors", :action => "index")
    end

    it "recognizes and generates #show" do
      { :get => "/web_visitors/1" }.should route_to(:controller => "web_visitors", :action => "show", :id => "1")
    end
  end
end
