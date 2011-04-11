class CreateTotems < ActiveRecord::Migration
  def self.up
    create_table :totems do |t|
      t.string :value, :length => 80
      t.string :ip, :length => 15
      t.integer :status_id
      t.string :user

      t.timestamps
    end
  end

  def self.down
    drop_table :totems
  end
end
