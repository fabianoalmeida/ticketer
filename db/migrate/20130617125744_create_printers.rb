class CreatePrinters < ActiveRecord::Migration
  def change
    create_table :printers do |t|
      t.string :name, :null => false
      t.string :slug

      t.timestamps
    end

    add_index :printers, :slug, unique: true
  end
end
