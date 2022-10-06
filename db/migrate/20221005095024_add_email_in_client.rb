class AddEmailInClient < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :notify_email, :string
  end
end
