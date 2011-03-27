require 'spec_helper'

describe Event do
  fixtures :events, :web_properties, :web_pages, :web_visitors
  let(:pwnall) { web_visitors :pwnall }
  let(:js_test) { web_properties :js_test }
  let(:test_page) { web_pages :test_page }
  let(:event) do
    Event.new :web_visitor => pwnall, :web_property => js_test,
              :page => test_page, :referrer => test_page,
              :browser_time => 1298789991386,
              :screen_info => '1ao.t6.o.t4.ey.az.e',
              :browser_ua => events(:test_load).browser_ua, :ip => '2.3.4.5',
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
    event.web_visitor = nil
    event.should_not be_valid    
  end
  
  it 'should require a visitor ip' do
    event.ip = nil
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

  it 'should require an user agent' do
    event.browser_ua = nil
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
  
  it 'should decode screen info correctly' do
    event.screen_width.should == 1680
    event.screen_height.should == 1050
    event.color_depth.should == 24
    event.document_width.should == 1048
    event.document_height.should == 538
    event.window_x.should == 395
    event.window_y.should == 14
  end
  
  it 'should accept negative window positions' do
    event.screen_info = "39s.140.o.t0.q6.-1c.-4"
    event.window_x.should == -48
    event.window_y.should == -4
    event.should be_valid
  end
  
  it 'should format for API correctly' do
    golden = {
      :referrer => web_pages(:test_page).to_api_hash,
      :page => web_pages(:test_page_alias).to_api_hash,
      :visitor => web_visitors(:pwnall).to_api_hash,
      :data => { '__' => 'page'},
      :pixels => {
        :screen => { :width=>1680, :height=>1050 },
        :window => { :x => 0, :y => 0 },
        :document => { :width => :document_width, :height => 931 }
      },
      :ip => '1.2.3.4',
      :browser => {
        :ua => 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/534.13 (KHTML, like Gecko) Ubuntu/10.10 Chromium/9.0.597.107 Chrome/9.0.597.107 Safari/534.13',
        :time => 1298799635048
      },
      :id => 545246930
    }
    events(:test_load).to_api_hash.should == golden
  end
  
  describe 'create_from_params' do
    let(:null_page) { web_pages :null_page }
    let(:params) do
      {
        '__pid' => js_test.uid, '__uid' => pwnall.uid,
        '__url' => test_page.url, '__ref' => null_page.url,
        '__time' => event.browser_time, '__px' => '1ao.t6.o.t4.ey.az.e',
        'controller' => 'event', 'action' => 'create', 'format' => 'gif'
      }.merge event.data
    end
    before do
      @web_event = Event.create_from_params params, 'Rails Testing', '0.0.0.0'
    end
    
    it 'should save event' do
      @web_event.should_not be_new_record
    end
    it 'should set web property' do
      @web_event.web_property.should == js_test
    end
    it 'should set visitor' do
      @web_event.web_visitor.should == pwnall
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
    it 'should set ip' do
      @web_event.ip.should == '0.0.0.0'
    end
    it 'should set user agent' do
      @web_event.browser_ua.should == 'Rails Testing'
    end
    it 'should decode metrics' do
      @web_event.screen_width.should == 1680
      @web_event.screen_height.should == 1050
      @web_event.color_depth.should == 24
      @web_event.document_width.should == 1048
      @web_event.document_height.should == 538
      @web_event.window_x.should == 395
      @web_event.window_y.should == 14
    end
  end
end
