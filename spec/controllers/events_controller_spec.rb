require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe EventsController do
  fixtures :events, :web_properties, :web_pages, :web_visitors

  def mock_event(stubs={})
    @mock_event ||= mock_model(Event, stubs).as_null_object
  end

  def mock_property(stubs={})
    @mock_property ||= mock_model(WebProperty, stubs).as_null_object
  end
  
  let(:db_property) { web_properties(:js_test) }


  describe "with http basic" do
    before(:each) do
      configvars_auth
    end
    
    describe "GET index" do
      it "assigns all events as @events" do
        get :index, :web_property_id => db_property.to_param
        assigns(:events).should include(events(:test_load))
      end
      
      describe "filtering" do
        it "uses names param whem given" do
          get :index, :web_property_id => db_property.to_param,
                      :names => [:page]
          assigns(:events).should eq([events(:test_load)])
        end
        
        it "decodes names param as array" do
          get :index, :web_property_id => db_property.to_param,
                      :names => [:page, :unload]
          assigns(:events).should eq([events(:test_load), events(:test_unload)])
        end
  
        it "defaults to all events" do
          get :index, :web_property_id => db_property.to_param, :names => []
          assigns(:events).should be_empty
        end
      end
      
      describe "limiting" do
        let(:mock_result) { [mock_event] }
        before do
          WebProperty.stub(:from_param).with('42') { mock_property }
          mock_property.stub(:events) { mock_result }
          mock_result.stub(:order) { mock_result }
          mock_result.stub(:where) { mock_result }
          mock_result.stub(:limit) { mock_result }
          mock_result.stub(:includes) { mock_result }
        end
        
        it "defaults to 200 records if no param is given" do
          mock_result.should_receive(:limit).with(200)
          get :index, :web_property_id => '42'
          assigns(:events).should == [mock_event]
        end

        it "uses limit param if given" do
          mock_result.should_receive(:limit).with(37)
          get :index, :web_property_id => '42', :limit => 37
          assigns(:events).should == [mock_event]
        end

        it "doesn't apply a limit for limit=no" do
          mock_result.should_not_receive(:limit)
          get :index, :web_property_id => '42', :limit => 'no'
          assigns(:events).should == [mock_event]
        end
      end
      
      describe "ordering" do
        let(:mock_result) { [mock_event] }
        before do
          WebProperty.stub(:from_param).with('42') { mock_property }
          mock_property.stub(:events) { mock_result }
          mock_result.stub(:order) { mock_result }
          mock_result.stub(:where) { mock_result }
          mock_result.stub(:limit) { mock_result }
          mock_result.stub(:includes) { mock_result }
        end
        
        it "defaults to descending ordering by ID" do
          mock_result.should_receive(:order).with('id DESC')
          get :index, :web_property_id => '42'
          assigns(:events).should == [mock_event]
        end
      end
    end

    describe "GET show" do
      it "assigns the requested event as @event" do
        Event.stub(:find).with("37") do
          mock_event(:web_property => mock_property)
        end
        get :show, :id => "37", :web_property_id => "42"
        assigns(:event).should be(mock_event)
      end
    end
    
    describe "GET index via JSON" do
      it "renders events via to_api_hash" do
        WebProperty.stub(:from_param).with('42') { mock_property }
        mock_result = [mock_event]
        mock_property.stub(:events) { mock_result }
        mock_result.stub(:order) { mock_result }
        mock_result.stub(:where) { mock_result }
        mock_result.stub(:limit) { mock_result }
        mock_result.stub(:includes) { mock_result }
        mock_event.stub(:to_api_hash) { { 'api' => 'hash' } }
        get :index, :web_property_id => '42', :format => 'json'
        ActiveSupport::JSON.decode(response.body).should == [{ 'api' => 'hash'}]
      end
    end

    describe "GET show via JSON" do
      it "renders requested event via to_api_hash" do
        Event.stub(:find).with('37') do
          mock_event(:web_property => mock_property)
        end
        mock_event.stub(:to_api_hash) { { 'api' => 'hash' } }
        get :show, :id => '37', :web_property_id => '42',
                   :format => 'json'
        ActiveSupport::JSON.decode(response.body).should == { 'api' => 'hash'}
      end
    end
  end

  describe "GET index" do
    it "fails without authorization" do
      get :show, :id => '37', :web_property_id => 'AA123456'
      response.status.should == 401
    end
  end

  describe "GET show" do
    it "fails without authorization" do
      get :show, :id => '37', :web_property_id => 'AA123456'
      response.status.should == 401
    end
  end
end
