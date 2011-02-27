require 'spec_helper'

describe "web_pages/edit.html.erb" do
  before(:each) do
    @web_page = assign(:web_page, stub_model(WebPage,
      :web_property_id => 1,
      :url => "MyString"
    ))
  end

  it "renders the edit web_page form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => web_pages_path(@web_page), :method => "post" do
      assert_select "input#web_page_web_property_id", :name => "web_page[web_property_id]"
      assert_select "input#web_page_url", :name => "web_page[url]"
    end
  end
end
