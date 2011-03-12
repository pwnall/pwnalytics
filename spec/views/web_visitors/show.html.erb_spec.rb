require 'spec_helper'

describe "web_visitors/show.html.erb" do
  fixtures :web_properties, :web_visitors
  before(:each) do
    @web_visitor = assign(:web_visitor, web_visitors(:pwnall))
  end

  it "renders attributes in <p>" do
    render
    rendered.should include(web_properties(:js_test).name)
    rendered.should include(@web_visitor.uid)
  end
end
