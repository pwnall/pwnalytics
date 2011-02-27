require 'spec_helper'

describe "web_visitors/index.html.erb" do
  fixtures :all
  before(:each) do
    assign(:web_visitors, WebVisitor.all)
  end

  it "renders a list of web_visitors" do
    render
    assert_select "tr>td", :text => web_properties(:js_test).name
    assert_select "tr>td", :text => web_visitors(:pwnall).uid
  end
end
