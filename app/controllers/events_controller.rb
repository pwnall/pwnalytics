class EventsController < ApplicationController
  config_vars_auth :except => [:new, :create]

  # GET /web_properties/1/events
  # GET /web_properties/1/events.json
  def index
    @web_property = WebProperty.find params[:web_property_id]
    @events = @web_property.events(:include => [:page, :referrer, :web_visitor])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @events.map(&:to_api_hash) }
    end
  end

  # GET /web_properties/1/events/1
  # GET /web_properties/1/events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @event.to_api_hash }
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
