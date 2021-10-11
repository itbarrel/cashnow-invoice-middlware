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

  private

  def order_attrs
    {
      "TRANSACTION_ID" => transaction_id,
      "ORDERTOTALCOLOUR" => order_total,
      "Terminal_id" => @order.order_terminal_id, 
      "Customer_id" => @order.customer_id, 
      "DISCCUST_DISCREASON" => nil
    }
  end
end
