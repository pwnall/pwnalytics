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

  # GET /web_pages/new
  # GET /web_pages/new.xml
  def new
    @web_page = WebPage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @web_page }
    end
  end

  # GET /web_pages/1/edit
  def edit
    @web_page = WebPage.find(params[:id])
  end

  # POST /web_pages
  # POST /web_pages.xml
  def create
    @web_page = WebPage.new(params[:web_page])

    respond_to do |format|
      if @web_page.save
        format.html { redirect_to(@web_page, :notice => 'Web page was successfully created.') }
        format.xml  { render :xml => @web_page, :status => :created, :location => @web_page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @web_page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /web_pages/1
  # PUT /web_pages/1.xml
  def update
    @web_page = WebPage.find(params[:id])

    respond_to do |format|
      if @web_page.update_attributes(params[:web_page])
        format.html { redirect_to(@web_page, :notice => 'Web page was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @web_page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /web_pages/1
  # DELETE /web_pages/1.xml
  def destroy
    @web_page = WebPage.find(params[:id])
    @web_page.destroy

    respond_to do |format|
      format.html { redirect_to(web_pages_url) }
      format.xml  { head :ok }
    end
  end
end
