require "spec_helper"

describe EventPostController do
  describe "routing" do
    it "recognizes and generates #create" do
      { :get => "/p.gif" }.should route_to(:controller => "event_post",
          :action => "create", :format => "gif")
    end
  end
end

describe EventJsController do
  describe "routing" do
    it "recognizes and generates #new" do
      { :get => "/p.js" }.should route_to(:controller => "event_js",
                                          :action => "new", :format => "js")
    end
  end
end
