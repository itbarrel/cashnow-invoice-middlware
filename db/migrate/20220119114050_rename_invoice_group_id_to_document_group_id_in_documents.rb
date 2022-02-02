class RenameInvoiceGroupIdToDocumentGroupIdInDocuments < ActiveRecord::Migration[6.1]
  def change
      rename_column :documents, :invoice_group_id, :document_group_id
  end
end
