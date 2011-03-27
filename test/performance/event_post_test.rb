require 'test_helper'
require 'rails/performance_test_help'

# Profiling results for each test method are written to tmp/performance.
class EventPostTest < ActionDispatch::PerformanceTest
  fixtures :all

  # By default, the tests run 4 times.
  self.profile_options = self.profile_options.merge(:runs => 100)
  
  def setup
    @pid = web_properties(:js_test).uid
    @uid = web_visitors(:pwnall).uid
    @url = web_pages(:test_page_alias).url
    @ref = web_pages(:test_page).url
    @ua = events(:test_load).browser_ua
  end
  
  def test_post_event
    js_test =
    
    get '/p.gif', {'__' => 'perf_test', '__pid' => @pid,
                   'time' => (Time.now.to_f * 1000).to_i, 'uid' => @uid,
                   '__url' => @url, '__ref' => @ref,
                   '__px' => '1ao.t6.o.t4.ey.az.e',
                   'text' => 'data' * 25}, {'HTTP_USER_AGENT' => @ua}
  end
end
