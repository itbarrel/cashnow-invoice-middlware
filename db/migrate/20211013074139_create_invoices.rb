# frozen_string_literal: true

class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices, id: :uuid do |t|
      t.json :data
      t.timestamps
    end
  end
end
