class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.string :value, :length => 80, :null => false

      t.references :status_ticket, :null => false
      t.references :ticket_type, :null => false
      t.references :place, :null => false
      t.references :totem, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
