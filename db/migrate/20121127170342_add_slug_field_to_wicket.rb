class AddSlugFieldToWicket < ActiveRecord::Migration
  def change
    add_column :wickets, :slug, :string
    
    add_index :wickets, :slug, unique: true
  end
end
