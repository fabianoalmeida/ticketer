class CreateReferenceGroupsWickets < ActiveRecord::Migration
  def self.up
    create_table :reference_groups_wickets, :id => false do |t|
      t.references :ticket_type_group, :wicket
    end
  end

  def self.down
    drop_table :reference_groups_wickets
  end
end
