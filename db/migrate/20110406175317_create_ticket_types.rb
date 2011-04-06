class CreateTicketTypes < ActiveRecord::Migration
  def self.up
    create_table :ticket_types do |t|
      t.string :value
      t.string :acronym
      t.string :user

      t.timestamps
    end
  end

  def self.down
    drop_table :ticket_types
  end
end
