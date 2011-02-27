require 'spec_helper'

describe WebPage do
  fixtures :web_properties, :web_pages
  
  let(:page) do
    WebPage.new :web_property => web_properties(:js_test),
                :web_property_uid => web_properties(:js_test).uid,
                :url => 'http://pivotal.github.com/jasmine/'
  end
  let(:test_page) { web_pages :test_page }
  
  it 'should validate healthy model' do
    page.should be_valid
  end
  
  it 'should require a url' do
    page.url = nil
    page.should_not be_valid
  end
  
  it 'should check for duplicate urls' do
    page.url = test_page.url
    page.should_not be_valid
  end
  
  it 'should require a web property' do
    page.web_property = nil
    page.should_not be_valid
  end

  it 'should require a web_property uid' do
    page.web_property_uid = nil
    page.should_not be_valid    
  end

  it 'should check web_property uid against the record' do
    page.web_property_uid = 'AZ123456'
    page.should_not be_valid
  end
  
  describe 'for' do
    let(:null_page) { web_pages :null_page }
    it 'should find existing page' do
      WebPage.for(test_page.web_property_uid, test_page.url).should == test_page
    end
    
    it 'should create page' do
      new_page = WebPage.for page.web_property_uid, page.url
      new_page.should_not be_new_record
      new_page.web_property_uid.should == page.web_property_uid
      new_page.url.should == page.url
    end
    
    it 'should return null page for empty URLs' do
      WebPage.for(null_page.web_property_uid, '').should == null_page
    end
    it 'should return null page for nil URLs' do
      WebPage.for(null_page.web_property_uid, nil).should == null_page
    end
    it 'should return null page for URLs set to null' do
      WebPage.for(null_page.web_property_uid, 'null').should == null_page
    end
  end
end
