class AddIndexesToTicketTypeGroup < ActiveRecord::Migration
  def change
    add_index :ticket_type_groups, :status_id
    add_index :ticket_type_groups, :places_ticket_type_groups_id
  end
end
