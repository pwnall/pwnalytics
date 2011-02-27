class CreateWebVisitors < ActiveRecord::Migration
  def self.up
    create_table :web_visitors do |t|
      t.integer :web_property_id, :null => false
      t.string :web_property_uid, :length => 8, :null => false
      t.string :uid, :length => 32, :null => false
    end
    add_index :web_visitors, [:web_property_uid, :uid], :null => false,
                                                        :unique => true
    add_index :web_visitors, [:web_property_id, :uid], :null => false,
                                                       :unique => true
  end

  def self.down
    drop_table :web_visitors
  end
end
