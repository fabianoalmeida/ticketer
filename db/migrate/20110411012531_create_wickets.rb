class CreateWickets < ActiveRecord::Migration
  def self.up
    create_table :wickets do |t|
      t.string :value, :length => 80
      t.integer :guidance_id
      t.integer :status_id
      t.string :user

      t.timestamps
    end
  end

  def self.down
    drop_table :wickets
  end
end
