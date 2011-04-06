require "spec_helper"

describe EventsFastController do
  describe "routing" do
    it "recognizes and generates #new" do
      { :get => "/p.js" }.should route_to(:controller => "events_fast",
                                          :action => "new", :format => "js")
    end

    it "recognizes and generates #create" do
      { :get => "/p.gif" }.should route_to(:controller => "events_fast",
          :action => "create", :format => "gif")
    end
  end
end
