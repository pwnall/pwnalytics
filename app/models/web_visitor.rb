# Unique visitor for a web property.
class WebVisitor < ActiveRecord::Base
  # The property that this visitor visits.
  belongs_to :web_property, :inverse_of => :web_visitors
  validates :web_property, :presence => true
  # De-normalized web_property.uid.
  validates :web_property_uid, :length => 8..8, :presence => true  
  validate :web_property_uid_matches
  # The ID used by the Pwnalytics JS to identify the visitor.
  validates :uid, :presence => true, :length => 1..32,
            :uniqueness => {:scope => :web_property_uid }
  # NOTE: the uniqueness scope is chosen to match the database index.

  # The events logged by this visitor.
  has_many :events, :foreign_key => 'visitor_id', :inverse_of => :web_visitor

  # Creates or retrieves a WebVisitor matching the arguments.
  def self.for(property_uid, uid)
    visitor = WebVisitor.where(:web_property_uid => property_uid, :uid => uid).
                         first
    return visitor if visitor
    
    return nil unless property = WebProperty.where(:uid => property_uid).first
    begin
      WebVisitor.create :web_property => property, :uid => uid,
                        :web_property_uid => property.uid
    rescue
      # NOTE: the visitor might have gotten created by a different server.
      # Concurrency yum yum.
      WebVisitor.where(:web_property_uid => property_uid, :uid => uid).first
    end
  end
  
  # Validates the correctness of the the de-normalized web_property_uid.
  def web_property_uid_matches
    return unless web_property
    unless web_property_uid == web_property.uid
      errors.add :web_property_uid, 'is inconsistent with web_property'
    end
  end
end
