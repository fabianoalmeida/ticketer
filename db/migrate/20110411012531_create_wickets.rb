class CreateWickets < ActiveRecord::Migration
  def self.up
    create_table :wickets do |t|
      t.string :value, :length => 80, :null => false
      t.string :user, :null => false
      
      t.references :guidance, :null => false
      t.references :status, :null => false
      t.references :place, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :wickets
  end
end
