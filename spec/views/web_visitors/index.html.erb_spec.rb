require 'spec_helper'

describe "web_visitors/index.html.erb" do
  before(:each) do
    assign(:web_visitors, [
      stub_model(WebVisitor,
        :web_property_id => 1,
        :uid => "Uid"
      ),
      stub_model(WebVisitor,
        :web_property_id => 1,
        :uid => "Uid"
      )
    ])
  end

  it "renders a list of web_visitors" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Uid".to_s, :count => 2
  end
end
