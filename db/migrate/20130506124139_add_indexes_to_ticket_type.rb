class AddIndexesToTicketType < ActiveRecord::Migration
  def change
    add_index :ticket_types, :ticket_type_group_id
    add_index :ticket_types, :status_id
    add_index :ticket_types, :priority
    add_index :ticket_types, :acronym
  end
end
