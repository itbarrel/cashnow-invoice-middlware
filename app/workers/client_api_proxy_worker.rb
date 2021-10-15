class ClientApiProxyWorker
  include Sidekiq::Worker

  def perform(client_id)
    client = Client.find_by_id(client_id)

    return if client.nil?
    return if client.login_api.nil?

    clientProxyObj = ClientProxy.new (client_id)
    
    response = clientProxyObj.authenticate

    response = JSON.parse(response[:message].to_json)
    error = response['error']
    # if success in response 
    if error == false
      # client find
      token = response['token']
      # client update with token placed in response
      client.update(token: token)
    end
  end
end
