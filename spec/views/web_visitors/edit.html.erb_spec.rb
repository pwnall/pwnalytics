require 'spec_helper'

describe "web_visitors/edit.html.erb" do
  before(:each) do
    @web_visitor = assign(:web_visitor, stub_model(WebVisitor,
      :web_property_id => 1,
      :uid => "MyString"
    ))
  end

  it "renders the edit web_visitor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => web_visitors_path(@web_visitor), :method => "post" do
      assert_select "input#web_visitor_web_property_id", :name => "web_visitor[web_property_id]"
      assert_select "input#web_visitor_uid", :name => "web_visitor[uid]"
    end
  end
end
