require 'spec_helper'

describe "web_visitors/new.html.erb" do
  before(:each) do
    assign(:web_visitor, stub_model(WebVisitor,
      :web_property_id => 1,
      :uid => "MyString"
    ).as_new_record)
  end

  it "renders new web_visitor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => web_visitors_path, :method => "post" do
      assert_select "input#web_visitor_web_property_id", :name => "web_visitor[web_property_id]"
      assert_select "input#web_visitor_uid", :name => "web_visitor[uid]"
    end
  end
end
