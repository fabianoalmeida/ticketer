class AddSlugFieldToTotem < ActiveRecord::Migration
  def change
    add_column :totems, :slug, :string
    
    add_index :totems, [:place_id, :slug], unique: true
  end
end
