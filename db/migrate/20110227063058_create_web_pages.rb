class CreateWebPages < ActiveRecord::Migration
  def self.up
    create_table :web_pages do |t|
      t.integer :web_property_id, :null => false
      t.string :web_property_uid, :length => 8, :null => false
      t.string :url, :limit => 148, :null => false
    end
    add_index :web_pages, [:web_property_uid, :url], :null => false,
                                                     :unique => true
    add_index :web_pages, [:web_property_id, :url], :null => false,
                                                    :unique => true
  end

  def self.down
    drop_table :web_pages
  end
end
