class ClientProxy < BaseProxy
  def initialize(client_id)
    @content  = ""
    @log_path = 'log/worker.log'
    @client_id = client_id
    @clientSerializer = ClientSerializer.new(client_id)
  end

  def authenticate
    payload = @clientSerializer.login_payload
    if payload.nil?
      @content += "##{@client_id} Client data not found\n"
      return nil
    end

    url =  @clientSerializer.api_url
    response = proxy_api(url, "POST", payload)

    if response.response.present? && response.code == 200
      @content += "##{@client_id} Client response >>>> Created: 200\n"
    else
      @content += "##{@client_id} Order response >>>>> #{response}\n"
    end

    return {code: response.code, message: response }
  end

end