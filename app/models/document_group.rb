# frozen_string_literal: true

class DocumentGroup < ApplicationRecord
  belongs_to :vendor
  has_many :documents, dependent: :destroy

  def filtered_documents(from_date, to_date)
    documents.having_date_between(from_date, to_date)
  end

  after_create_commit { broadcast_prepend_to 'document_groups' }
  after_update_commit { broadcast_replace_to 'document_groups' }
  after_destroy_commit { broadcast_remove_to 'document_groups' }
end
