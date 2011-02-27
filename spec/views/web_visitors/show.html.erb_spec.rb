require 'spec_helper'

describe "web_visitors/show.html.erb" do
  before(:each) do
    @web_visitor = assign(:web_visitor, stub_model(WebVisitor,
      :web_property_id => 1,
      :uid => "Uid"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Uid/)
  end
end
