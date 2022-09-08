class AddColumnsInClient < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :ftp_host, :string
    add_column :clients, :ftp_port, :string
    add_column :clients, :ftp_user, :string
    add_column :clients, :ftp_password, :string
  end
end
