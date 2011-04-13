class AddNamesToEvents < ActiveRecord::Migration
  def self.up
    # add_column :events, :name, :string, :null => true
    
    Event.find_each do |event|
      event.name = event.data['__'] || 'null'
      new_data = event.data.dup
      new_data.delete '__'
      event.data = new_data
      event.save!
    end
    
    change_column :events, :name, :string, :null => false
    add_index :events, [:web_property_id, :name], :null => false,
                                                  :unique => false
  end

  def self.down
    Event.find_each do |event|
      event.data = event.data.merge '__' => event.name
      event.save!
    end
    remove_column :events, :name
  end
end
