class CreatePlacesTicketTypeGroups < ActiveRecord::Migration
  def self.up
    create_table :places_ticket_type_groups, :id => false do |t|
      t.integer :ticket_type_group_id, :null => false
      t.integer :place_id, :null => false
    end
  end

  def self.down
    drop_table :places_ticket_type_groups
  end
end
