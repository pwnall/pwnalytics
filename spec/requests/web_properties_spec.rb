require 'spec_helper'

describe "WebProperties" do
  describe "GET /web_properties" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get web_properties_path
      response.status.should be(200)
    end
  end
end
