class AddColumnInVendors < ActiveRecord::Migration[6.1]
  def change
    add_column :vendors, :name, :string
  end
end
