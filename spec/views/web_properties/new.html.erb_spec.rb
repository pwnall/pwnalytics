require 'spec_helper'

describe "web_properties/new.html.erb" do
  before(:each) do
    assign(:web_property, WebProperty.new)
  end

  it "renders new web_property form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => web_properties_path, :method => "post" do
      assert_select "input#web_property_name", :name => "web_property[name]"
    end
  end
end
