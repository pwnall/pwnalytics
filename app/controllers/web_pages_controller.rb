class WebPagesController < ApplicationController
  # GET /web_pages
  # GET /web_pages.xml
  def index
    @web_pages = WebPage.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @web_pages }
    end
  end

  # GET /web_pages/1
  # GET /web_pages/1.xml
  def show
    @web_page = WebPage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @web_page }
    end
  end
end
