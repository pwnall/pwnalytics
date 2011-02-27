require 'spec_helper'

describe "web_properties/show.html.erb" do
  fixtures :web_properties
  
  before(:each) do
    @web_property = assign(:web_property, web_properties(:js_test))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Property ID/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
