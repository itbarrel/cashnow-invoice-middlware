class FtpClientWorker
    include Sidekiq::Worker

    def perform(client_id)
        client = Client.find_by_id(client_id)
        connection = FtpClient.new.connection(client)
        if connection.present?
            f = connection.nlst('*.txt')
            f.each do |x|
                connection.gettextfile(x)
            end
            connection.close()
        end
    end
end