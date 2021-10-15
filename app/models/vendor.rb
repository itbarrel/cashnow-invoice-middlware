class Vendor < ApplicationRecord
  belongs_to :client
  has_many :invoice_groups, dependent: :destroy
  has_many :invoices, through: :invoice_groups, dependent: :destroy
end
