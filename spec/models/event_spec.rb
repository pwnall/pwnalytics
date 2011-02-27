require 'spec_helper'

describe Event do
  fixtures :events, :web_properties, :web_pages, :web_visitors
  let(:pwnall) { web_visitors :pwnall }
  let(:js_test) { web_properties :js_test }
  let(:test_page) { web_pages :test_page }
  let(:event) do
    Event.new :visitor => pwnall, :web_property => js_test, :page => test_page,
              :referrer => test_page, :browser_time => 1298789991386,
              :data => {'__' => 'whatever', 'pixie' => 'dust'}
  end
  
  it 'should validate healthy model' do
    event.should be_valid
  end
  
  it 'should set data_json' do
    event.data_json.should_not be_nil
  end
  
  it 'should require a web property' do
    event.web_property = nil
    event.should_not be_valid
  end
  
  it 'should require a visitor' do
    event.visitor = nil
    event.should_not be_valid    
  end
  
  it 'should require a page' do
    event.page = nil
    event.should_not be_valid
  end

  it 'should require a referrer page' do
    event.referrer = nil
    event.should_not be_valid    
  end

  it 'should require event data' do
    event.data = nil
    event.should_not be_valid
  end

  it 'should require JSON-encoded event data' do
    event.data_json = nil
    event.should_not be_valid
  end
  
  it 'should encode and decode data correctly' do
    event.save!
    Event.find(event.id).data.should == event.data
  end
  
  describe 'create_from_params' do
    let(:null_page) { web_pages :null_page }
    let(:params) do
      {
        '__pid' => js_test.uid, '__uid' => pwnall.uid,
        '__url' => test_page.url, '__ref' => null_page.url,
        '__time' => event.browser_time,
        'controller' => 'event', 'action' => 'create', 'format' => 'gif'
      }.merge event.data
    end
    before do
      @web_event = Event.create_from_params params
    end
    
    it 'should save event' do
      @web_event.should_not be_new_record
    end
    it 'should set web property' do
      @web_event.web_property.should == js_test
    end
    it 'should set visitor' do
      @web_event.visitor.should == pwnall
    end
    it 'should set page' do
      @web_event.page.should == test_page
    end
    it 'should set referrer' do
      @web_event.referrer.should == null_page
    end
    it 'should remove metadata from event properties' do
      @web_event.data.should == event.data
    end
  end
end
