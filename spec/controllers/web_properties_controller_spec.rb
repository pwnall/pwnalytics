require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe WebPropertiesController do

  def mock_web_property(stubs={})
    @mock_web_property ||= mock_model(WebProperty, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all web_properties as @web_properties" do
      WebProperty.stub(:all) { [mock_web_property] }
      get :index
      assigns(:web_properties).should eq([mock_web_property])
    end
  end

  describe "GET show" do
    it "assigns the requested web_property as @web_property" do
      WebProperty.stub(:find).with("37") { mock_web_property }
      get :show, :id => "37"
      assigns(:web_property).should be(mock_web_property)
    end
  end

  describe "GET new" do
    it "assigns a new web_property as @web_property" do
      WebProperty.stub(:new) { mock_web_property }
      get :new
      assigns(:web_property).should be(mock_web_property)
    end
  end

  describe "GET edit" do
    it "assigns the requested web_property as @web_property" do
      WebProperty.stub(:find).with("37") { mock_web_property }
      get :edit, :id => "37"
      assigns(:web_property).should be(mock_web_property)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created web_property as @web_property" do
        WebProperty.stub(:new).with({'these' => 'params'}) { mock_web_property(:save => true) }
        post :create, :web_property => {'these' => 'params'}
        assigns(:web_property).should be(mock_web_property)
      end

      it "redirects to the created web_property" do
        WebProperty.stub(:new) { mock_web_property(:save => true) }
        post :create, :web_property => {}
        response.should redirect_to(web_property_url(mock_web_property))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved web_property as @web_property" do
        WebProperty.stub(:new).with({'these' => 'params'}) { mock_web_property(:save => false) }
        post :create, :web_property => {'these' => 'params'}
        assigns(:web_property).should be(mock_web_property)
      end

      it "re-renders the 'new' template" do
        WebProperty.stub(:new) { mock_web_property(:save => false) }
        post :create, :web_property => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested web_property" do
        WebProperty.stub(:find).with("37") { mock_web_property }
        mock_web_property.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :web_property => {'these' => 'params'}
      end

      it "assigns the requested web_property as @web_property" do
        WebProperty.stub(:find) { mock_web_property(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:web_property).should be(mock_web_property)
      end

      it "redirects to the web_property" do
        WebProperty.stub(:find) { mock_web_property(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(web_property_url(mock_web_property))
      end
    end

    describe "with invalid params" do
      it "assigns the web_property as @web_property" do
        WebProperty.stub(:find) { mock_web_property(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:web_property).should be(mock_web_property)
      end

      it "re-renders the 'edit' template" do
        WebProperty.stub(:find) { mock_web_property(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested web_property" do
      WebProperty.stub(:find).with("37") { mock_web_property }
      mock_web_property.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the web_properties list" do
      WebProperty.stub(:find) { mock_web_property }
      delete :destroy, :id => "1"
      response.should redirect_to(web_properties_url)
    end
  end

end
