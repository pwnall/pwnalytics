class EventsController < ApplicationController
  config_vars_auth :except => [:new, :create]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @event }
    end
  end

  # GET /events/new
  def new
    render :text => PwnalyticsJS::PwnalyticsJS.main_js(create_event_url)
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.create_from_params params, request.user_agent,
                                      request.remote_ip
    render :text => PwnalyticsJS::PwnalyticsJS.gif_contents
  end
end
