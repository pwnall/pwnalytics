class WebVisitorsController < ApplicationController
  # GET /web_properties/AA123456/web_visitors
  # GET /web_properties/AA123456/web_visitors.json
  def index
    web_property = WebProperty.from_param params[:web_property_id]
    @web_visitors = web_property.web_visitors

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @web_visitors.map(&:to_api_hash) }
    end
  end

  # GET /web_properties/AA123456/web_visitors/1
  # GET /web_properties/AA123456/web_visitors/1.json
  def show
    @web_visitor = WebVisitor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @web_visitor.to_api_hash }
    end
  end
end
