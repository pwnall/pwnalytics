require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe EventsFastController do
  def mock_event(stubs={})
    @mock_event ||= mock_model(Event, stubs).as_null_object
  end
  
  describe "GET new.js" do
    it "renders the Pwnalytics main JS" do
      get :new, :format => 'js'
      response.body.should include('Pwnalytics.onLoad')
    end
    
    it "contains the correct event post backend URL" do
      get :new, :format => 'js'
      response.body.should include(create_event_path)
    end
  end

  describe "GET create.gif" do
    describe "with valid params" do
      it "assigns a newly created event as @event" do
        Event.stub(:create_from_params).with({'controller' => 'events_fast',
            'action' => 'create', 'these' => 'params'}, 'Rails Testing',
            '0.0.0.0') { mock_event(:save => true) }
        get :create, {'these' => 'params'}, :format => 'gif'
        assigns(:event).should be(mock_event)
      end

      it "renders the gif file" do
        Event.stub(:new) { mock_event(:save => true) }
        get :create, :event => {}
        response.body.should == PwnalyticsJS::PwnalyticsJS.gif_contents
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved event as @event" do
        Event.stub(:create_from_params).with({'controller' => 'events_fast',
            'action' => 'create', 'these' => 'params'}, 'Rails Testing',
            '0.0.0.0') { mock_event(:save => false) }
        get :create, {'these' => 'params'}, :format => 'gif'
        assigns(:event).should be(mock_event)
      end

      it "renders the gif file" do
        Event.stub(:create_from_params) { mock_event(:save => false) }
        get :create, :format => 'gif'
        response.body.should == PwnalyticsJS::PwnalyticsJS.gif_contents
      end
    end
  end
end
