class CreateStatusTickets < ActiveRecord::Migration
  def self.up
    create_table :status_tickets do |t|
      t.string :value, :length => 80, :null => false
      t.string :acronym, :length => 1, :null => false
      t.string :user, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :status_tickets
  end
end
