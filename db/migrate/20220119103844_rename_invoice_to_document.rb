class RenameDocumentToDocument < ActiveRecord::Migration[6.1]
  def change
    rename_table :invoices, :documents 
  end
end
