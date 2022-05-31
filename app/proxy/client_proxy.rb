# frozen_string_literal: true

class ClientProxy < BaseProxy
  def initialize(client_id)
    @content  = ''
    @log_path = 'log/worker.log'
    @client_id = client_id
    @client_serializer = ClientSerializer.new(client_id)
    super()
  end

  def authenticate
    payload = @client_serializer.login_payload
    if payload.nil?
      @content += "##{@client_id} Client data not found\n"
      return nil
    end

    url = @client_serializer.api_url
    response = proxy_api(url, 'POST', payload)

    @content += if response.response.present? && response.code == 200
                  "##{@client_id} Client response >>>> Created: 200\n"
                else
                  "##{@client_id} Order response >>>>> #{response}\n"
                end

    { code: response.code, message: response }
  end

  def fetch_data_for(api, vendor)
    payload = @client_serializer.fetch_data_payload(vendor)
    if payload.nil?
      @content += "##{@client_id} Client data not found\n"
      return nil
    end

    url = api.api_url
    response = proxy_api(url, 'POST', payload)

    @content += if response.response.present? && response.code == 200
                  "##{@client_id} Client response >>>> Created: 200\n"
                else
                  "##{@client_id} Order response >>>>> #{response}\n"
                end

    { code: response.code, message: response }
  end
end
