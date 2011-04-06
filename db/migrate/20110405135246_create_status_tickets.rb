class CreateStatusTickets < ActiveRecord::Migration
  def self.up
    create_table :status_tickets do |t|
      t.string :value, :lenght => 80
      t.string :acronym, :lenght => 1
      t.string :user

      t.timestamps
    end
  end

  def self.down
    drop_table :status_tickets
  end
end
