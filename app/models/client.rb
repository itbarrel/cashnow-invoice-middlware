class Client < ApplicationRecord
    has_many :vendors, dependent: :destroy
    
    enum api_method: [:get_method, :post_method]
end
