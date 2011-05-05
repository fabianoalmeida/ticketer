class AddGuidanceFieldFlag < ActiveRecord::Migration
  def self.up
    add_column :wickets, :guidance, :boolean 
  end

  def self.down
    remove_column :wickets, :guidance
  end
end
