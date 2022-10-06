# frozen_string_literal: true

class RenameApiColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :apis, :record_type, :document_type
  end
end
