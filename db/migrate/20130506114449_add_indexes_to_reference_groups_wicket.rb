class AddIndexesToReferenceGroupsWicket < ActiveRecord::Migration
  def change
    add_index :reference_groups_wickets, :ticket_type_group_id
    add_index :reference_groups_wickets, :wicket_id
  end
end
