class EventJsController < ApplicationController
  config_vars_auth :except => :new
  
  # GET /p.js
  def new
    self.status = 200
    self.content_type = 'text/javascript'
    self.response_body = PwnalyticsJS::PwnalyticsJS.main_js(create_event_url)
  end
end
