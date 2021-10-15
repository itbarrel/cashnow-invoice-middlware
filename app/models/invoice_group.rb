class InvoiceGroup < ApplicationRecord
    belongs_to :vendor
    has_many :invoices

    after_create_commit { broadcast_prepend_to 'invoice_groups' }
    after_update_commit { broadcast_replace_to 'invoice_groups' }
    after_destroy_commit { broadcast_remove_to 'invoice_groups' }
end
