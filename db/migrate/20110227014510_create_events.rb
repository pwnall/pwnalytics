class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :web_property_id, :null => false
      t.integer :visitor_id, :null => false
      t.integer :page_id, :null => false
      t.integer :referrer_id, :null => false
      t.integer :browser_time, :limit => 8, :null => false
      t.integer :screen_width, :null => false
      t.integer :screen_height, :null => false
      t.integer :color_depth, :null => false
      t.integer :document_width, :null => false
      t.integer :document_height, :null => false
      t.integer :window_x, :null => false
      t.integer :window_y, :null => false
      t.text :data_json, :limit => 4.kilobytes, :null => false
      t.datetime :created_at
    end
    add_index :events, [:visitor_id, :browser_time], :null => false,
                                                     :unique => false
    add_index :events, [:web_property_id, :page_id, :browser_time],
                       :null => false, :unique => false
  end

  def self.down
    drop_table :events
  end
end
