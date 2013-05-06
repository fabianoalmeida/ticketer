class AddIndexesToStatus < ActiveRecord::Migration
  def change
    add_index :statuses, :value
  end
end
