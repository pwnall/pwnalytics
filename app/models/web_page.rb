# A page on the Web.
class WebPage < ActiveRecord::Base
  # The property that this page is related to.
  belongs_to :web_property, :inverse_of => :web_pages
  validates :web_property, :presence => true
  # De-normalized web_property.uid.
  validates :web_property_uid, :length => 8..8, :presence => true
  validate :web_property_uid_matches
  # The page's URL.
  validates :url, :presence => true, :length => 1..148,
            :uniqueness => {:scope => :web_property_uid }
  # NOTE: the uniqueness scope is chosen to match the database index.
  
  # Events generated on this page.
  has_many :events, :foreign_key => 'page_id', :inverse_of => :page

  # Creates or retrieves a WebPage matching the arguments.
  def self.for(property_uid, url)
    url = normalize_url url
    page = WebPage.where(:web_property_uid => property_uid, :url => url).first
    return page if page
    
    return nil unless property = WebProperty.where(:uid => property_uid).first
    begin
      WebPage.create :web_property => property, :url => url,
                     :web_property_uid => property.uid
    rescue
      # NOTE: the visitor might have gotten created by a different server.
      # Concurrency yum yum.
      WebPage.where(:web_property_uid => property_uid, :url => url).first
    end
  end
  
  # Chops up a URL to make it suitable for the Pwnalytics database.
  def self.normalize_url(url)
    return 'null' if url.blank?
    if query_index = url.index(??)
      url = url[0, query_index + 1]
    end
    url = url[0, 148] if url.length > 148
    url
  end
  
  # Validates the correctness of the the de-normalized web_property_uid.
  def web_property_uid_matches
    return unless web_property
    unless web_property_uid == web_property.uid
      errors.add :web_property_uid, 'is inconsistent with web_property'
    end
  end
  
  # Page data, formatted for use in API responses.
  def to_api_hash
    { :url => url }
  end
end
