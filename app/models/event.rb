# The atomic unit of tracking.
class Event < ActiveRecord::Base
  # The user who caused this event.
  belongs_to :web_visitor, :foreign_key => 'visitor_id',
             :class_name => 'WebVisitor', :inverse_of => :events
  validates :web_visitor, :presence => true
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

  # Width (X) of the user's screen resolution. 1024 in 1024x768
  validates :screen_width, :presence => true,
      :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  # Height (Y) of the user's screen resolution. 768 in 1024x768
  validates :screen_height, :presence => true,
      :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  # Color bits per pixel. 24 for true color.
  validates :color_depth, :presence => true,
      :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  # Width (X) of the browser's client area. Excludes toolbars etc.
  validates :document_width, :presence => true,
      :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  # Height (Y) of the browser's client area. Excludes toolbars etc.
  validates :document_height, :presence => true,
      :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  # The browser window's X position on screen.
  validates :window_x, :presence => true,
      :numericality => { :only_integer => true }
  # The browser window's Y position on screen.
  validates :window_y, :presence => true,
      :numericality => { :only_integer => true }

  # The IP address of the incoming HTTP request.
  validates :ip, :length => 1..64, :presence => true
  # The browser's User-Agent header.
  validates :browser_ua, :length => 1..256, :presence => true
  
  # Event name.
  validates :name, :length => 1..32, :presence => true

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
  def self.create_from_params(request_params, user_agent, ip)
    data = request_params.dup
    
    property_uid = data.delete('__pid')
    visitor = WebVisitor.for property_uid, data.delete('__uid')
    return nil unless visitor
    page = WebPage.for property_uid, data.delete('__url')
    referrer = WebPage.for property_uid, data.delete('__ref')
    browser_time = data.delete '__time'
    screen_info = data.delete '__px'
    name = data.delete('__') || 'null'
    ['format', 'controller', 'action'].each do |rails_header|
      data.delete rails_header
    end
    Event.create :web_property_id => visitor.web_property_id,
                 :web_visitor => visitor, :browser_time => browser_time,
                 :page => page, :referrer => referrer, :name => name[0, 32],
                 :data => data, :screen_info => screen_info,
                 :browser_ua => user_agent[0, 256], :ip => ip[0, 64]
  end
  
  # Virtual attribute that decodes the PwnalyticsJS screen info string.
  def screen_info=(info_string)
    bits = info_string.split('.').map { |bit| bit.to_i 36 }
    self.screen_width, self.screen_height, self.color_depth,
        self.document_width, self.document_height,
        self.window_x, self.window_y = *bits
  end

  # Checks that the web property is denormalized correctly.
  def web_property_matches_visitor
    return unless web_visitor
    unless web_property_id == web_visitor.web_property_id
      errors.add :web_property_id, 'is inconsistent with visitor'
    end
    return true
  end
  private :web_property_matches_visitor
  
  # Event data, formatted for use in API responses.
  def to_api_hash
    {
      :id => id,
      :pixels => {
        :document => { :height => document_height, :width => :document_width },
        :screen => { :width => screen_width, :height => screen_height },
        :window => { :x => window_x, :y => window_y }, 
      },
      :browser => {
        :time => browser_time, :ua => browser_ua,
      },
      :ip => ip, :name => name, :data => data,
      :page => page.to_api_hash, :referrer => referrer.to_api_hash,
      :visitor => web_visitor.to_api_hash
    }
  end
end
