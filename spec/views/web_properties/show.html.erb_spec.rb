require 'spec_helper'

describe "web_properties/show.html.erb" do
  fixtures :web_properties
  
  before(:each) do
    @html_snippet = assign(:html_snippet, "<js_snippet>ohai</js_snippet>")
    @web_property = assign(:web_property, web_properties(:js_test))
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/Property ID/)
    rendered.should match(/Name/)
  end
  
  include ERB::Util
  it "renders tracking snippet" do
    render
    assert_select "section pre", :text => /#{h(@html_snippet)}/
  end
end
