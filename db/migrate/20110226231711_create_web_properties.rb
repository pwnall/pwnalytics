class CreateWebProperties < ActiveRecord::Migration
  def self.up
    create_table :web_properties do |t|
      t.string :uid, :length => 8, :null => false
      t.string :name, :length => 128, :null => false
    end
    add_index :web_properties, :uid, :unique => true
  end

  def self.down
    drop_table :web_properties
  end
end
