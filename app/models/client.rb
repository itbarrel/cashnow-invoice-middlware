# frozen_string_literal: true

class Client < ApplicationRecord
  has_many :apis, -> { fetch_data }, dependent: :destroy
  has_one :login_api, -> { authenticate }, class_name: 'Api', dependent: :destroy
  has_many :vendors, dependent: :destroy
  has_many :document_groups, through: :vendors
  has_many :documents, through: :vendors

  accepts_nested_attributes_for :login_api
  validates_associated :login_api

  before_validation { self.api_token = SecureRandom.hex(15) if api_token.blank? }

  def renew_api_token
    self.api_token = SecureRandom.hex(15)
    save
  end

  after_create_commit { broadcast_prepend_to 'clients' }
  after_update_commit { broadcast_replace_to 'clients' }
  after_destroy_commit { broadcast_remove_to 'clients' }
end
