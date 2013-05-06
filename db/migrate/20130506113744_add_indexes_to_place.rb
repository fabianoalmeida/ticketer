class AddIndexesToPlace < ActiveRecord::Migration
  def change
    add_index :places, :status_id
    add_index :places, :local_id
    add_index :places, :places_ticket_type_groups_id
  end
end
