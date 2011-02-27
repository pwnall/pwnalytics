require 'spec_helper'

describe WebProperty do
  fixtures :web_properties
  
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
  
  describe 'random_uid' do
    let(:uids) { Array.new(32) { WebProperty.random_uid } }
    it 'should generate unique ids' do
      uids.uniq.should have(32).items
    end
  end
end
