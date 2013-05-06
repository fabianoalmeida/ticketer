class AddIndexesToTotem < ActiveRecord::Migration
  def change
    add_index :totems, :status_id
    add_index :totems, :place_id
  end
end
