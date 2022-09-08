class FtpServerWorker
    include Sidekiq::Worker

    def perform(client_id)
        client = Client.find_by_id(client_id)
        connection = CashnowF.new.connection(client)
        if connection.present?
            f = connection.nlst('*.txt')
            f.each do |x|
                connection.gettextfile(x)
            end
        end
        connection.close()
        return true unless connection.closed?()
    end
    
end