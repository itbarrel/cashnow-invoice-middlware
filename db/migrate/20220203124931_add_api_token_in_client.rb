# frozen_string_literal: true

class AddApiTokenInClient < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :api_token, :text, unique: true
  end
end
