class FtpClientsWorker
    include Sidekiq::Worker

    def perform
        Client.find_each do |client|
            FtpClientWorker.perform_async(client.id)
        end
    end
end
