class AddFieldAlternateToWicket < ActiveRecord::Migration
  def self.up
    add_column :wickets, :alternate, :boolean, :default => false
  end

  def self.down
    remove_column :wickets, :alternate, :boolean
  end
end
