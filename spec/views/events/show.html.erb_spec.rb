require 'spec_helper'

describe "events/show.html.erb" do
  fixtures :all
  before(:each) do
    @event = assign(:event, events(:test_load))
  end

  it "renders attributes in <p>" do
    render
    rendered.should include(@event.web_property.name)
    rendered.should include(@event.web_visitor.uid)
    rendered.should include(@event.page.url)
    rendered.should include(@event.referrer.url)
    rendered.should include(@event.browser_time.to_s)
  end
end
