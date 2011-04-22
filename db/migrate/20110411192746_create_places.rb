class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.string :value, :length => 80, :null => false
      t.string :user, :null => false

      t.references :status, :null => false
      t.references :local, :null => false
      t.references :places_ticket_type

      t.timestamps
    end
  end

  def self.down
    drop_table :places
  end
end
