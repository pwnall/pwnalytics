class EventPostController < ActionController::Metal
  include ActionController::Rescue
  
  # GET /p.gif
  def create
    event = Event.create_from_params params, request.user_agent,
                                     request.remote_ip
    self.status = 200
    self.content_type = 'image/gif'
    self.response_body = PwnalyticsJS::PwnalyticsJS.gif_contents
  end
end
