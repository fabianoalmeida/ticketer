class AddSlugFieldToPanel < ActiveRecord::Migration
  def change
    add_column :panels, :slug, :string
    
    add_index :panels, [:place_id, :slug], unique: true
  end
end
