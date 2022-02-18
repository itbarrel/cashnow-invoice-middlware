# frozen_string_literal: true

class RenameDocumentToDocument < ActiveRecord::Migration[6.1]
  def change
    rename_table :invoices, :documents
  end
end
