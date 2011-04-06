describe "Pwnalytics events posting" do
  def mock_event(stubs={})
    @mock_event ||= mock_model(Event, stubs).as_null_object
  end
  
  describe "GET /p.js" do
    it "renders the Pwnalytics main JS" do
      get '/p.js'
      response.body.should include('Pwnalytics.onLoad')
    end
    
    it "contains the correct event post backend URL" do
      get '/p.js'
      response.body.should include(create_event_path)
    end
  end

  describe "GET /p.gif" do
    describe "with valid params" do
      it "assigns a newly created event as @event" do
        Event.stub(:create_from_params).with({'controller' => 'events_fast',
            'action' => 'create', 'these' => 'params'}, 'Rails Testing',
            '127.0.0.1') { mock_event(:save => true) }
        request.user_agent = 'Rails Testing'
        get '/p.gif', {'these' => 'params'}
        assigns(:event).should be(mock_event)
      end

      it "renders the gif file" do
        Event.stub(:new) { mock_event(:save => true) }
        get '/p.gif', :event => {}
        response.body.should == PwnalyticsJS::PwnalyticsJS.gif_contents
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved event as @event" do
        Event.stub(:create_from_params).with({'controller' => 'events_fast',
            'action' => 'create', 'these' => 'params'}, 'Rails Testing',
            '127.0.0.1') { mock_event(:save => false) }
        get '/p.gif', {'these' => 'params'}
        assigns(:event).should be(mock_event)
      end

      it "renders the gif file" do
        Event.stub(:create_from_params) { mock_event(:save => false) }
        get '/p.gif'
        response.body.should == PwnalyticsJS::PwnalyticsJS.gif_contents
      end
    end
  end
end
