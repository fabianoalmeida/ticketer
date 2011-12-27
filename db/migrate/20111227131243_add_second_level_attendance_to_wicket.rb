class AddSecondLevelAttendanceToWicket < ActiveRecord::Migration
  def self.up
    add_column :wickets, :second_level, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :wickets, :second_level
  end
end
