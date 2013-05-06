class AddIndexesToTicket < ActiveRecord::Migration
  def change
    add_index :tickets, :status_ticket_id
    add_index :tickets, :ticket_type_id
    add_index :tickets, :place_id
    add_index :tickets, :totem_id
    add_index :tickets, :state
    add_index :tickets, :created_at
  end
end
