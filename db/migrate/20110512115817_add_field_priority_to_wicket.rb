class AddFieldPriorityToWicket < ActiveRecord::Migration
  def self.up
    add_column :wickets, :priority, :boolean 
  end

  def self.down
    remove_column :wickets, :priority
  end
end
