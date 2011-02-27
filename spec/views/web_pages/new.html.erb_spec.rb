require 'spec_helper'

describe "web_pages/new.html.erb" do
  before(:each) do
    assign(:web_page, stub_model(WebPage,
      :web_property_id => 1,
      :url => "MyString"
    ).as_new_record)
  end

  it "renders new web_page form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => web_pages_path, :method => "post" do
      assert_select "input#web_page_web_property_id", :name => "web_page[web_property_id]"
      assert_select "input#web_page_url", :name => "web_page[url]"
    end
  end
end
