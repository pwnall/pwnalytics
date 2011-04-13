class WebPagesController < ApplicationController
  # GET /web_properties/AA123456/web_pages
  # GET /web_properties/AA123456/web_pages.json
  def index
    web_property = WebProperty.from_param params[:web_property_id]
    @web_pages = web_property.web_pages

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @web_pages.map(&:to_api_hash) }
    end
  end

  # GET /web_properties/AA123456/web_pages/1
  # GET /web_properties/AA123456/web_pages/1.json
  def show
    @web_page = WebPage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @web_page.to_api_hash }
    end
  end
end
