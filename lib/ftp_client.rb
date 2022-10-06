class FtpClient
    def connection(client_id)
        client = Client.find_by_id(client_id)
        Net::FTP.new(host = "#{client.ftp_host}" , options = {
            "port": "#{client.ftp_port}" || "21",
            "username": "#{client.ftp_user}",
            "password": "#{client.ftp_password}"
        })
        rescue Errno::ECONNREFUSED
    end
end
