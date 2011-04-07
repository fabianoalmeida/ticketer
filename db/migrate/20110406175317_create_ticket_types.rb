class CreateTicketTypes < ActiveRecord::Migration
  def self.up
    create_table :ticket_types do |t|
      t.string :value, :length => 80
      t.string :acronym, :length => 1
      t.string :user
      t.integer :status_id

      t.timestamps
    end

    add_index(:ticket_types, :status_id)
  end

  def self.down
    drop_table :ticket_types
  end
end
