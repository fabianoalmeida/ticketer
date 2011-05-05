class RemoveColumnForEntityGuidanceFromWicket < ActiveRecord::Migration
  def self.up
    remove_column :wickets, :guidance_id
  end

  def self.down
    change_tabel :wickets do |t| 
      t.references :guidances
    end
  end
end
