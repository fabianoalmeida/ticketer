class AddIndexesToPlaceTicketTypeGroup < ActiveRecord::Migration
  def change
    add_index :places_ticket_type_groups, :ticket_type_group_id
    add_index :places_ticket_type_groups, :place_id
  end
end
