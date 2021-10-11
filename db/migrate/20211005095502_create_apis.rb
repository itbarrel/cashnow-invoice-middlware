class CreateApis < ActiveRecord::Migration[6.1]
  def change
    create_table :apis, id: :uuid do |t|
      t.integer :api_type
      t.integer :api_method
      t.string :api_url
      t.references :client, index: true, type: :uuid

      t.timestamps
    end
  end
end
