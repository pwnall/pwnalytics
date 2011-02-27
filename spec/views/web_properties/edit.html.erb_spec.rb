require 'spec_helper'

describe "web_properties/edit.html.erb" do
  fixtures :web_properties
  
  before(:each) do
    @web_property = assign(:web_property, web_properties(:js_test))
  end

  it "renders the edit web_property form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => web_properties_path(@web_property), :method => "post" do
      assert_select "input#web_property_name", :name => "web_property[name]"
    end
  end
end
