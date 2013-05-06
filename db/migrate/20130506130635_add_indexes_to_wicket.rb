class AddIndexesToWicket < ActiveRecord::Migration
  def change
    add_index :wickets, :status_id
    add_index :wickets, :place_id
    add_index :wickets, :created_at
  end
end
