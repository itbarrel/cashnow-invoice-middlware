# frozen_string_literal: true

class CreateVendors < ActiveRecord::Migration[6.1]
  def change
    create_table :vendors, id: :uuid do |t|
      t.string :vendor_code
      t.references :client, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
