# frozen_string_literal: true

class ClientSerializer
  def initialize(client_id)
    @client = Client.find_by_id(client_id)
  end

  def api_url
    return nil if @client.nil?

    @client.login_api.api_url
  end

  def login_payload
    return nil if @client.nil?

    {
      'client_id' => @client.username,
      'password' => @client.password
    }
  end

  def fetch_data_payload(vendor)
    return nil if @client.nil?
    return nil if @client.token.nil?
    return nil if vendor.nil?

    from_date = 30.days.ago.strftime('%Y%m%d')
    to_date = Time.zone.now.strftime('%Y%m%d')

    {
      'client_id' => @client.username,
      'token' => @client.token,
      'vendor_code' => vendor.vendor_code,
      'from_date' => from_date,
      'to_date' => to_date
    }
  end
end
