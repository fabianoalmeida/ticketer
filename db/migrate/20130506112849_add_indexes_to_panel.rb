class AddIndexesToPanel < ActiveRecord::Migration
  def change
    add_index :panels, :status_id
    add_index :panels, :place_id
  end
end
