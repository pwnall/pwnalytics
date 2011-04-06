class EventsFastController < ActionController::Metal
  include ActionController::UrlFor
  include ActionController::Routing
  
  include ActionController::Instrumentation
  include ActionController::Rescue
  
  # GET /p.js
  def new
    self.response_body = PwnalyticsJS::PwnalyticsJS.main_js(create_event_url)
  end

  # GET /p.gif
  def create
    @event = Event.create_from_params params, request.user_agent,
                                      request.remote_ip
    self.response_body = PwnalyticsJS::PwnalyticsJS.gif_contents
  end
end
