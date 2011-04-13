require 'spec_helper'

describe "events/index.html.erb" do
  fixtures :all
  before(:each) do
    @web_property = assign(:web_property, web_properties(:js_test))
    @events = assign(:events, @web_property.events)
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => events(:test_load).web_visitor.uid
    assert_select "tr>td", :text => events(:test_load).page.url
    assert_select "tr>td", :text => events(:test_load).referrer.url
    assert_select "tr>td", :text => events(:test_load).browser_time.to_s
    assert_select "tr>td", :text => events(:test_load).name.to_s
  end
end
