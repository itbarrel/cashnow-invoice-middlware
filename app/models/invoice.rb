class Invoice < ApplicationRecord
  belongs_to :invoice_group
  delegate :vendor, to: :invoice_group, allow_nil: true

  after_create_commit { broadcast_prepend_to 'invoices' }
  after_update_commit { broadcast_replace_to 'invoices' }
  after_destroy_commit { broadcast_remove_to 'invoices' }
  
  # scope :having_date_between, ->(start_date, end_date) { where("data->>'vendor_invoice_date')::date > ?", start_date) }
  scope :having_date_between, lambda {|start_date, end_date|
    list = all.where("(data->>'vendor_invoice_date')::date > ?", start_date) if start_date.present?
    list = list.where("(data->>'vendor_invoice_date')::date < ?", end_date) if end_date.present?
    list
  } 

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
          invoice.data['vendor_invoice_date'].to_date.strftime('%d-%m-%Y'),
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
