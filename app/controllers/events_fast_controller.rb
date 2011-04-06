class EventsFastController < ApplicationController
  config_vars_auth :except => [:new, :create]
  
  # GET /p.js
  def new
    render :text => PwnalyticsJS::PwnalyticsJS.main_js(create_event_url)
  end

  # GET /p.gif
  def create
    @event = Event.create_from_params params, request.user_agent,
                                      request.remote_ip
    render :text => PwnalyticsJS::PwnalyticsJS.gif_contents
  end
end
