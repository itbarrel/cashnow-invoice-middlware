class CreateInvoiceGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :invoice_groups, id: :uuid do |t|
      t.string :title
      t.references :vendor, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
    add_reference :invoices, :invoice_group, index: true, type: :uuid
  end
end
