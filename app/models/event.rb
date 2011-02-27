# The atomic unit of tracking.
class Event < ActiveRecord::Base
  # The user who caused this event.
  belongs_to :visitor, :class_name => 'WebVisitor'
  validates :visitor, :presence => true
  # De-normalized vistor.web_property.
  belongs_to :web_property, :class_name => 'WebProperty'
  validate :web_property_matches_visitor
  # The page on which the event occurred.
  belongs_to :page, :class_name => 'WebPage'
  validates :page, :presence => true
  # The referrer of the page on which the event occurred.
  belongs_to :referrer, :class_name => 'WebPage'
  validates :referrer, :presence => true
  
  # The browser-side timestamp (UNIX time, in milliseconds) for the event.
  validates :browser_time, :presence => true, 
      :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  # All the event's properties.
  validates :data_json, :presence => true

  # Virtual attribute that unrolls the JSON data.
  def data=(new_data)
    @data = nil
    self.data_json = new_data && ActiveSupport::JSON.encode(new_data)
  end
  def data
    @data ||= ActiveSupport::JSON.decode(data_json).freeze
  end
  
  # Creates an event based on the data in a Web request.
  def self.create_from_params(request_params)
    params = request_params.clone
    
    property_uid = params.delete('__pid')
    visitor = WebVisitor.for property_uid, params.delete('__vid')
    return nil unless visitor
    page = WebPage.for property_uid, params.delete('__url')
    referrer = WebPage.for property_uid, params.delete('__ref')
    browser_time = params.delete '__time'
    Event.create :web_property_id => visitor.web_property_id,
                 :visitor => visitor, :browser_time => browser_time,
                 :page => page, :referrer => referrer, :data => params
  end

  # Checks that the web property is denormalized correctly.
  def web_property_matches_visitor
    return unless visitor
    unless web_property_id == visitor.web_property_id
      errors.add :web_property_id, 'is inconsistent with visitor'
    end
    return true
  end
  private :web_property_matches_visitor
end
