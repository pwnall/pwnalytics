# A collection of pages that are tracked together.
class WebProperty < ActiveRecord::Base
  # User-friendly name.
  validates :name, :presence => true, :length => 1..128
  
  # Used by the Pwnalytics JS to report analytics data.
  validates :uid, :presence => true, :length => 8..8, :uniqueness => true,
                  :format => /^[0-9A-F]+$/
  
  # Visitors logged on this property.
  has_many :web_visitors, :inverse_of => :web_property
  # Events generated on this property.
  has_many :events, :inverse_of => :web_property
  
  # Generates a unique ID for this property.
  def generate_uid
    self.uid ||= self.class.random_uid
  end
  before_validation :generate_uid
  
  # Computes a UID that should be unique by virtue of randomness.
  def self.random_uid
    OpenSSL::Random.random_bytes(4).unpack('H*').first.upcase
  end
end
