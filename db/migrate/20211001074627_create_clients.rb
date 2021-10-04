class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients, id: :uuid do |t|
      t.string     :client_code
      t.string     :password
      t.string     :email
      t.string     :api_url
      t.integer    :api_method
      t.text       :token
      t.timestamps
    end
  end
end
