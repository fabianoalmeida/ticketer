class AddIndexesToTicketTypeGroupsWicket < ActiveRecord::Migration
  def change
    add_index :ticket_type_groups_wickets, :ticket_type_group_id
    add_index :ticket_type_groups_wickets, :wicket_id
  end
end
