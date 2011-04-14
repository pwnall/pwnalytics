class EventsController < ApplicationController
  config_vars_auth

  # GET /web_properties/AA123456/events
  # GET /web_properties/AA123456/events.json
  def index
    @web_property = WebProperty.from_param params[:web_property_id]
    @events = @web_property.events.includes(:page, :referrer, :web_visitor,
                                            :web_property).order('id DESC')
    
    # Limiting.
    if params[:limit]
      limit = params[:limit] == 'no' ? nil : params[:limit].to_i
    else
      limit = 200
    end
    @events = @events.limit(limit) if limit

    # Filtering.
    @events = @events.where(:name => params[:names]) if params[:names]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @events.map(&:to_api_hash) }
    end
  end

  # GET /web_properties/AA123456/events/1
  # GET /web_properties/AA123456/events/1.json
  def show
    @event = Event.find params[:id]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @event.to_api_hash }
    end
  end
end
