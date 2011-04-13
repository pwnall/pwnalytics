require 'spec_helper'

describe WebProperty do
  fixtures :web_properties
  
  let(:db_property) { web_properties(:js_test) }
  let(:property) do
    WebProperty.new :name => 'My Awesome Site'
  end
  
  it 'should validate healthy properties' do
    property.should be_valid
  end
  
  it 'should require names' do
    property.name = nil
    property.should_not be_valid
  end
  
  it 'should auto-fill UIDs' do
    property.valid?
    property.uid.should_not be_nil
  end
  
  it 'should accept custom UIDs' do
    property.uid = 'AB123456'
    property.should be_valid
    property.uid.should == 'AB123456'
  end
  
  it 'should not accept malformed UIDs' do
    property.uid = 'AX123456'
    property.should_not be_valid
  end
  
  it 'should not accept short UIDs' do
    property.uid = 'AA12345'
    property.should_not be_valid
  end
  
  it 'should not accept duplicate UIDs' do
    property.uid = web_properties(:js_test).uid
    property.should_not be_valid
  end
  
  describe 'json serialization' do
    let(:json) { ActiveSupport::JSON.decode(db_property.to_json) }
    
    it 'should have the UID' do
      json['uid'].should == db_property.uid
    end
    
    it 'should not have the ActiveRecord ID' do
      json['id'].should be_nil
    end
  end
  
  describe 'to_param' do
    let(:param) { db_property.to_param }
    
    it 'should match UID' do
      param.should == db_property.uid
    end
  end
  
  describe 'from_param' do
    let(:param) { db_property.to_param }
    
    it 'should be the inverse of to_param' do
      WebProperty.from_param(param).should == db_property
    end
    
    it 'should return nil for an invalid UID' do
      WebProperty.from_param('xoxo').should be_nil
    end
    
    it 'should return when given nil' do
      WebProperty.from_param(nil).should be_nil
    end
  end
  
  describe 'random_uid' do
    let(:uids) { Array.new(32) { WebProperty.random_uid } }
    it 'should generate unique ids' do
      uids.uniq.should have(32).items
    end
  end
end
