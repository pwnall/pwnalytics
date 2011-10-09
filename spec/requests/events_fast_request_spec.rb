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
      response.body.should include('http://www.example.com/p.gif')
    end
  end

  describe "GET /p.gif" do
    describe "with valid params" do
      it "creates an event" do
        Event.stub(:create_from_params).with({'controller' => 'event_post',
            'action' => 'create', 'these' => 'params', 'format' => 'gif'},
            'Rails Testing', '127.0.0.1') { mock_event(:save => true) }
        get '/p.gif', {'these' => 'params'},
                      {'HTTP_USER_AGENT' => 'Rails Testing'}
      end

      it "renders the gif file" do
        Event.stub(:new) { mock_event(:save => true) }
        get '/p.gif', :event => {}
        response.body.should == PwnalyticsJS::PwnalyticsJS.gif_contents
      end
    end

    describe "with invalid params" do
      it "attempts to create an event" do
        Event.stub(:create_from_params).with({'controller' => 'event_post',
            'action' => 'create', 'these' => 'params', 'format' => 'gif'},
            'Rails Testing', '127.0.0.1') { mock_event(:save => false) }
        get '/p.gif', {'these' => 'params'},
                      {'HTTP_USER_AGENT' => 'Rails Testing'}
      end

      it "renders the gif file" do
        Event.stub(:create_from_params) { mock_event(:save => false) }
        get '/p.gif'
        response.body.should == PwnalyticsJS::PwnalyticsJS.gif_contents
      end
    end
  end
end
