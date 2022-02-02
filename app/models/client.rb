class Client < ApplicationRecord
    has_many :apis, -> { fetch_data }, dependent: :destroy
    has_one :login_api, -> { authenticate }, class_name: 'Api', dependent: :destroy
    has_many :vendors, dependent: :destroy
    has_many :documents, through: :vendors

    accepts_nested_attributes_for :login_api
    validates_associated :login_api

    after_create_commit { broadcast_prepend_to 'clients' }
    after_update_commit { broadcast_replace_to 'clients' }
    after_destroy_commit { broadcast_remove_to 'clients' }

end
