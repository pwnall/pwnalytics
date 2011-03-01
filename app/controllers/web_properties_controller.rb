class WebPropertiesController < ApplicationController
  # GET /web_properties
  # GET /web_properties.json
  def index
    @web_properties = WebProperty.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @web_properties }
    end
  end

  # GET /web_properties/1
  # GET /web_properties/1.json
  def show
    @web_property = WebProperty.find(params[:id])
    js_snippet = PwnalyticsJS::PwnalyticsJS.insertion_js new_event_url,
                                                         @web_property.uid
    @html_snippet = %Q|<script type="text/javascript">\n  #{js_snippet}\n</script>|

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @web_property }
    end
  end

  # GET /web_properties/new
  # GET /web_properties/new.json
  def new
    @web_property = WebProperty.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @web_property }
    end
  end

  # GET /web_properties/1/edit
  def edit
    @web_property = WebProperty.find(params[:id])
  end

  # POST /web_properties
  # POST /web_properties.json
  def create
    @web_property = WebProperty.new(params[:web_property])

    respond_to do |format|
      if @web_property.save
        format.html { redirect_to(@web_property, :notice => 'Web property was successfully created.') }
        format.json { render :json => @web_property, :status => :created, :location => @web_property }
      else
        format.html { render :action => "new" }
        format.json { render :json => @web_property.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /web_properties/1
  # PUT /web_properties/1.json
  def update
    @web_property = WebProperty.find(params[:id])

    respond_to do |format|
      if @web_property.update_attributes(params[:web_property])
        format.html { redirect_to(@web_property, :notice => 'Web property was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @web_property.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /web_properties/1
  # DELETE /web_properties/1.json
  def destroy
    @web_property = WebProperty.find(params[:id])
    @web_property.destroy

    respond_to do |format|
      format.html { redirect_to(web_properties_url) }
      format.json { head :ok }
    end
  end
end
