# A page on the Web.
class WebPage < ActiveRecord::Base
  # The property that this page is related to.
  belongs_to :web_property
  validates :web_property, :presence => true
  # De-normalized web_property.uid.
  validates :web_property_uid, :length => 8..8, :presence => true
  validate :web_property_uid_matches
  # The page's URL.
  validates :url, :presence => true, :length => 1..148,
            :uniqueness => {:scope => :web_property_uid }
  # NOTE: the uniqueness scope is chosen to match the database index.

  # Creates or retrieves a WebPage matching the arguments.
  def self.for(property_uid, url)
    page = WebPage.where(:web_property_uid => property_uid, :url => url).first
    return page if page
    
    return nil unless property = WebProperty.where(:uid => property_uid).first
    WebPage.create :web_property => property, :url => url,
                   :web_property_uid => property.uid
  end
  
  # Validates the correctness of the the de-normalized web_property_uid.
  def web_property_uid_matches
    return unless web_property
    unless web_property_uid == web_property.uid
      errors.add :web_property_uid, 'is inconsistent with web_property'
    end
  end
end
