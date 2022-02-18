# frozen_string_literal: true

class AddColumnInDocumentgroup < ActiveRecord::Migration[6.1]
  def change
    add_column :invoice_groups, :downloaded, :boolean, default: false
  end
end
