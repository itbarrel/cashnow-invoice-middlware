class ClientSerializer
  def initialize(client_id)
    @client = Client.find_by_id(client_id)

    return nil if @client.nil?

    @client
  end
  
  def api_url
    return nil if @client.nil?

    return @client.login_api.api_url
  end

  def login_payload
    return nil if @client.nil?

    return {
      "client_id" => @client.username,
      "password" => @client.password,
    }
  end

  def fetch_data_payload(vendor)
    return nil if @client.nil?
    return nil if @client.token.nil?
    return nil if vendor.nil?

   return {
      "client_id" => @client.username,
      "token" => @client.token,
      "vendor_code" => vendor.vendor_code,
    }
  end
end
