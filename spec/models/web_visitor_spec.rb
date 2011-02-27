require 'spec_helper'

describe WebVisitor do
  fixtures :web_properties, :web_visitors
  
  let(:visitor) do
    WebVisitor.new :web_property => web_properties(:js_test),
                   :web_property_uid => web_properties(:js_test).uid,
                   :uid => '12e68ebfdbf.73568fc32b13585a'
  end
  let(:pwnall) { web_visitors :pwnall }
  
  it 'should validate healthy model' do
    visitor.should be_valid
  end
  
  it 'should require a uid' do
    visitor.uid = nil
    visitor.should_not be_valid
  end
  
  it 'should check for duplicate uids' do
    visitor.uid = pwnall.uid
    visitor.should_not be_valid
  end
  
  it 'should require a web property' do
    visitor.web_property = nil
    visitor.should_not be_valid
  end

  it 'should require a web_property uid' do
    visitor.web_property_uid = nil
    visitor.should_not be_valid    
  end

  it 'should check web_property uid against the record' do
    visitor.web_property_uid = 'AZ123456'
    visitor.should_not be_valid
  end
  
  describe 'for' do
    it 'should find existing visitor' do
      WebVisitor.for(pwnall.web_property_uid, pwnall.uid).should == pwnall
    end
    
    it 'should create visitor' do
      new_visitor = WebVisitor.for(visitor.web_property_uid, visitor.uid)
      new_visitor.should_not be_new_record
      new_visitor.web_property_uid.should == visitor.web_property_uid
      new_visitor.uid.should == visitor.uid
    end
  end
end
