require 'spec_helper'

describe "web_pages/show.html.erb" do
  fixtures :web_pages, :web_properties
  before(:each) do
    assign(:web_page, web_pages(:test_page))
  end
  
  it "renders attributes in <p>" do
    render
    rendered.should include(web_properties(:js_test).name)
    rendered.should include(web_pages(:test_page).url)
  end
end
