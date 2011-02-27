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

  # GET /web_visitors/new
  # GET /web_visitors/new.xml
  def new
    @web_visitor = WebVisitor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @web_visitor }
    end
  end

  # GET /web_visitors/1/edit
  def edit
    @web_visitor = WebVisitor.find(params[:id])
  end

  # POST /web_visitors
  # POST /web_visitors.xml
  def create
    @web_visitor = WebVisitor.new(params[:web_visitor])

    respond_to do |format|
      if @web_visitor.save
        format.html { redirect_to(@web_visitor, :notice => 'Web visitor was successfully created.') }
        format.xml  { render :xml => @web_visitor, :status => :created, :location => @web_visitor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @web_visitor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /web_visitors/1
  # PUT /web_visitors/1.xml
  def update
    @web_visitor = WebVisitor.find(params[:id])

    respond_to do |format|
      if @web_visitor.update_attributes(params[:web_visitor])
        format.html { redirect_to(@web_visitor, :notice => 'Web visitor was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @web_visitor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /web_visitors/1
  # DELETE /web_visitors/1.xml
  def destroy
    @web_visitor = WebVisitor.find(params[:id])
    @web_visitor.destroy

    respond_to do |format|
      format.html { redirect_to(web_visitors_url) }
      format.xml  { head :ok }
    end
  end
end
