require 'spec_helper'

describe "web_pages/show.html.erb" do
  before(:each) do
    @web_page = assign(:web_page, stub_model(WebPage,
      :web_property_id => 1,
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Url/)
  end
end
