class CreateTicketTypes < ActiveRecord::Migration
  def self.up
    create_table :ticket_types do |t|
      t.string :value, :length => 80, :null => false
      t.string :acronym, :length => 1, :null => false
      t.string :user, :null => false

      t.references :ticket_type_group, :null => false
      t.references :status, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :ticket_types
  end
end
