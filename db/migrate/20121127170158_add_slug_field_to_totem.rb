class AddSlugFieldToTotem < ActiveRecord::Migration
  def change
    add_column :totems, :slug, :string
    
    add_index :totems, :slug, unique: true
  end
end
