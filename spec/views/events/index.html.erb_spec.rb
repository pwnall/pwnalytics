require 'spec_helper'

describe "events/index.html.erb" do
  fixtures :all
  before(:each) do
    assign(:events, Event.all)
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => web_properties(:js_test).name
    assert_select "tr>td", :text => events(:test_load).page.url
    assert_select "tr>td", :text => events(:test_load).referrer.url
    assert_select "tr>td", :text => events(:test_load).browser_time.to_s
  end
end
