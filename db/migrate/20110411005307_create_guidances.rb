class CreateGuidances < ActiveRecord::Migration
  def self.up
    create_table :guidances do |t|
      t.string :value, :length => 20, :null => false
      t.string :user, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :guidances
  end
end
