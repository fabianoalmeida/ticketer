class AddPrinterToTotem < ActiveRecord::Migration
  def change
    add_column :totems, :printer_id, :integer

    add_index :totems, :printer_id
  end
end
