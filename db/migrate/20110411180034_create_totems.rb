class CreateTotems < ActiveRecord::Migration
  def self.up
    create_table :totems do |t|
      t.string :value, :length => 80, :null => false
      t.string :ip, :length => 15, :null => false
      t.string :user, :null => false

      t.references :status, :null => false
      t.references :place, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :totems
  end
end
