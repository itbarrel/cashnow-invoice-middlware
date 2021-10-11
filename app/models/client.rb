class Client < ApplicationRecord
    has_many :apis, -> { fetch_data }, dependent: :destroy
    has_one :login_api, -> { authenticate }, class_name: 'Api', dependent: :destroy
    
    has_many :vendors, dependent: :destroy

    accepts_nested_attributes_for :login_api
end
