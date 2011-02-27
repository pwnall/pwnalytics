require 'spec_helper'

describe "web_properties/index.html.erb" do
  fixtures :web_properties
  
  before(:each) do
    assign(:web_properties, WebProperty.all)
  end

  it "renders a list of web_properties" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => web_properties(:js_test).name, :count => 1
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => web_properties(:js_test).uid, :count => 1
  end
end
