class AddFieldSequentialByTypeGroupToPlace < ActiveRecord::Migration
  def change
    add_column :places, :sequential_by_type_group, :boolean, :default => false, :null => false
  end
end
