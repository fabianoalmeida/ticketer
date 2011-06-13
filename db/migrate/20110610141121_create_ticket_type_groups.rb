class CreateTicketTypeGroups < ActiveRecord::Migration
  def self.up
    create_table :ticket_type_groups do |t|
      t.string :value, :length => 80, :null => false
      t.string :user, :null => false

      t.references :status, :null => false
      t.references :places_ticket_type_groups

      t.timestamps
    end
  end

  def self.down
    drop_table :ticket_type_groups
  end
end
