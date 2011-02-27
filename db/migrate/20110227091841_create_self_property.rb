class CreateSelfProperty < ActiveRecord::Migration
  def self.up
    WebProperty.create :uid => 'AA123456', :name => 'Pwnalytics itself'
  end

  def self.down
    WebProperty.where(:uid => 'AA123456').first.destroy
  end
end
