class WebVisitorsController < ApplicationController
  # GET /web_visitors
  # GET /web_visitors.xml
  def index
    @web_visitors = WebVisitor.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @web_visitors }
    end
  end

  # GET /web_visitors/1
  # GET /web_visitors/1.xml
  def show
    @web_visitor = WebVisitor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @web_visitor }
    end
  end
end
