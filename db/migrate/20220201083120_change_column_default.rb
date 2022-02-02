class ChangeColumnDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :vendors, :created_at, -> { 'CURRENT_TIMESTAMP' }
    change_column_default :vendors, :updated_at, -> { 'CURRENT_TIMESTAMP' }
  end
end
