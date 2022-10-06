# frozen_string_literal: true

class Api < ApplicationRecord
  enum api_type: %i[authenticate fetch_data]
  enum api_method: %i[get_method post_method]

  belongs_to :client, optional: true

  validates_presence_of :api_type, :api_method, :api_url

  def display_method
    case api_method
    when 'get_method', 0
      'GET'
    when 'post_method', 1
      'POST'
    else
      'GET'
    end
  end
end
