class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.string :value, :length => 80
      t.string :user

      t.references :status
      t.references :local

      t.timestamps
    end
  end

  def self.down
    drop_table :places
  end
end
