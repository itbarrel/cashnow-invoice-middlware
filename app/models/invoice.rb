class Invoice < ApplicationRecord
  belongs_to :invoice_group
  delegate :vendor, to: :invoice_group, allow_nil: true
  # delegate :client, to: :vendor, allow_nil: true

  after_create_commit { broadcast_prepend_to 'invoices' }
  after_update_commit { broadcast_replace_to 'invoices' }
  after_destroy_commit { broadcast_remove_to 'invoices' }

  # def self.to_csv
  #   CSV.generate do |csv|
  #     csv << column_names
  #     all.each do |invoice|
  #       csv << invoice.attributes.values_at(*column_names)
  #     end
  #   end      
  # end
  def self.to_csv
    disply_attributes = [
      'Supplier Id',
      'Supplier Name',
      'Invoice Number',
      'Invoice Date',
      'Maturity Date',
      'Invoice Amount',
      'Tax Amount',
      'Invoice Total',
    ]

    CSV.generate(headers: true) do |csv|
      csv << disply_attributes

      all.each do |invoice|
        row_data = [
          invoice.vendor.vendor_code,
          invoice.data['vendor_name'],
          invoice.data['vendor_invoice_no'],
          invoice.data['vendor_invoice_date'].to_date.strftime('%d/%m/%y'),
          nil,
          invoice.data['vendor_invoice_amount'].to_f,
          invoice.data['vendor_invoice_tax'].to_f,
          (invoice.data['vendor_invoice_amount'].to_f + invoice.data['vendor_invoice_tax'].to_f),
        ]
        csv << row_data
      end
    end
  end
  
end
