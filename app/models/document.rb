# frozen_string_literal: true

class Document < ApplicationRecord
  belongs_to :document_group
  delegate :vendor, to: :document_group, allow_nil: true

  after_create_commit { broadcast_prepend_to 'documents' }
  after_update_commit { broadcast_replace_to 'documents' }
  after_destroy_commit { broadcast_remove_to 'documents' }

  scope :having_date_between, lambda { |start_date, end_date|
    list = all
    list = list.where("(data->>'vendor_invoice_date')::date >= ?", start_date) if start_date.present?
    list = list.where("(data->>'vendor_invoice_date')::date <= ?", end_date) if end_date.present?
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
      'Invoice Total'
    ]

    CSV.generate(headers: true) do |csv|
      csv << disply_attributes

      all.each do |document|
        row_data = [
          document.vendor.vendor_code,
          document.data['vendor_name'],
          document.data['vendor_invoice_no'],
          document.data['vendor_invoice_date'].to_date.strftime('%d-%m-%Y'),
          nil,
          (document.data['vendor_invoice_amount'].to_f - document.data['vendor_invoice_tax'].to_f),
          document.data['vendor_invoice_tax'].to_f,
          document.data['vendor_invoice_amount'].to_f
        ]
        csv << row_data
      end
    end
  end
end
