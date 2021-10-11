class HardWorker
  include Sidekiq::Worker

  def perform(name, count)
    # Do something
    # HardWorker.perform_async('bob', 5)
    # cd = ClientSerializer.new(client_id)
    # cc = ClientProxy.new (Client.last)
    # cc.authenticate
  end
end
