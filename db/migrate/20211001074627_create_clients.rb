class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients, id: :uuid do |t|
      t.string     :name
      t.string     :company_name
      t.string     :username
      t.string     :password      
      t.text       :token
      t.timestamps
    end
  end
end
