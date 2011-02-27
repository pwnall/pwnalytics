require 'spec_helper'

describe "events/new.html.erb" do
  before(:each) do
    assign(:event, stub_model(Event,
      :web_property_id => 1,
      :browser_time => 1,
      :data => "MyText"
    ).as_new_record)
  end

  it "renders new event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => events_path, :method => "post" do
      assert_select "input#event_web_property_id", :name => "event[web_property_id]"
      assert_select "input#event_browser_time", :name => "event[browser_time]"
      assert_select "textarea#event_data", :name => "event[data]"
    end
  end
end
