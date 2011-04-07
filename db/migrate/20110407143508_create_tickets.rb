class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.string :value, :length => 80
      t.integer :ticket_type_id
      t.integer :status_ticket_id

      t.timestamps
    end

    add_index( :tickets, :ticket_type_id )
    add_index( :tickets, :status_ticket_id )
  end

  def self.down
    drop_table :tickets
  end
end
