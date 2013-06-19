class AddTemplateFieldToPrinter < ActiveRecord::Migration
  def change
    add_column :printers, :template, :text
  end
end
