# frozen_string_literal: true

class FtpClient
  def connection(client_id)
    client = Client.find_by_id(client_id)
    Net::FTP.new(host = client.ftp_host.to_s, options = {
                   "port": client.ftp_port.to_s || '21',
                   "username": client.ftp_user.to_s,
                   "password": client.ftp_password.to_s
                 })
  rescue Errno::ECONNREFUSED
  end
end
