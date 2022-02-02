class AddColumnToApi < ActiveRecord::Migration[6.1]
  def change
    add_column :apis, :record_type, :string
  end
end
