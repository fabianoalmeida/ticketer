class CreateLocals < ActiveRecord::Migration
  def self.up
    create_table :locals do |t|
      t.string :value, :length => 80
      t.string :user

      t.timestamps
    end
  end

  def self.down
    drop_table :locals
  end
end
