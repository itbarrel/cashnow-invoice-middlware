class RenameDocumentGroupToDocumentGroup < ActiveRecord::Migration[6.1]
  def change
        rename_table :invoice_groups, :document_groups 
  end
end
