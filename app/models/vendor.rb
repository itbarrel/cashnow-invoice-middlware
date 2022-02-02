class Vendor < ApplicationRecord
  belongs_to :client
  has_many :document_groups, dependent: :destroy
  has_many :documents, through: :document_groups, dependent: :destroy
end
