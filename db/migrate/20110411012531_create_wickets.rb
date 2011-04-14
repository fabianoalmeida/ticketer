class CreateWickets < ActiveRecord::Migration
  def self.up
    create_table :wickets do |t|
      t.string :value, :length => 80
      t.string :user
      
      t.references :guidance
      t.references :status
      t.references :place

      t.timestamps
    end
  end

  def self.down
    drop_table :wickets
  end
end
