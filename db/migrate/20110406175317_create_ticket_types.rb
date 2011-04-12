class CreateTicketTypes < ActiveRecord::Migration
  def self.up
    create_table :ticket_types do |t|
      t.string :value, :length => 80
      t.string :acronym, :length => 1
      t.string :user

      t.timestamps
    end
  end

  def self.down
    drop_table :ticket_types
  end
end
