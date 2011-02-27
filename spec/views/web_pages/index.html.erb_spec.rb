require 'spec_helper'

describe "web_pages/index.html.erb" do
  fixtures :all
  before(:each) do
    assign(:web_pages, WebPage.all)
  end

  it "renders a list of web_pages" do
    render
    assert_select "tr>td", :text => web_properties(:js_test).name
    assert_select "tr>td", :text => web_pages(:test_page).url
  end
end
