require 'spec_helper'

describe "WebVisitors" do
  describe "GET /web_visitors" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get web_visitors_path
      response.status.should be(200)
    end
  end
end
