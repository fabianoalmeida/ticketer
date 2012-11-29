class AddSlugFieldToPanel < ActiveRecord::Migration
  def change
    add_column :panels, :slug, :string
    
    add_index :panels, :slug, unique: true
  end
end
