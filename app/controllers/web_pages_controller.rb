class WebPagesController < ApplicationController
  # GET /web_properties/1/web_pages
  # GET /web_properties/1/web_pages.json
  def index
    web_property = WebProperty.find params[:web_property_id]
    @web_pages = web_property.web_pages

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @web_pages }
    end
  end

  # GET /web_properties/1/web_pages/1
  # GET /web_properties/1/web_pages/1.json
  def show
    @web_page = WebPage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @web_page }
    end
  end
end
