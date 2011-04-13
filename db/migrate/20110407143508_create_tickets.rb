class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.string :value, :length => 80

      t.references :status_ticket
      t.references :ticket_type

      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
