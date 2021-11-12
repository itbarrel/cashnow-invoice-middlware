class VendorApiProxyWorker
  include Sidekiq::Worker

  def post_invoice(data_to_post, vendor)
    formated_time = Time.now.in_time_zone('Asia/Karachi').strftime('%a, %d %B %Y')
    # formated_time = Time.now.in_time_zone('Asia/Karachi').strftime('%a, %d %B %Y %I:%M %p')
    ig = InvoiceGroup.where(title: formated_time, vendor: vendor).first_or_create
    duplicate_invoices = ig.invoices.where("data->>'vendor_invoice_no' = ?", data_to_post['vendor_invoice_no'])
    data_to_post['vendor_invoice_date'] = data_to_post['vendor_invoice_date'].to_date.strftime('%d-%b-%Y')
    if duplicate_invoices.length.zero?
      Invoice.create(data: data_to_post, invoice_group: ig)
    else
      duplicate_invoices.first.update(data: data_to_post)
    end
  end

  def perform(client_id, api_id, vendor_id)

    client = Client.find_by_id(client_id)
    return if client.nil?
    return if client.token.nil?

    api = Api.find_by(id: api_id, client: client)
    return if api.nil?

    vendor = client.vendors.find_by_id(vendor_id)
    return if vendor.nil?

    clientProxyObj = ClientProxy.new (client_id)

    if api.fetch_data?
      response = clientProxyObj.fetch_data_for(api, vendor)
      response = JSON.parse(response[:message])
      # response.['vendor_invoice_date'].to_date.strftime('%d-%b-%y')
      error = response['error']
      data = response['data']
      # response['vendor_invoice_date'].to_date.strftime('%d/%m/%y')
      # data['vendor_invoice_date'].to_date.strftime('%d/%m/%y')
      
      # if success in response 
      if error == false
        if data.kind_of?(Array)
          data.each do |elem|
            post_invoice(elem, vendor)
          end
        else
          post_invoice(data, vendor)
        end
      else
        if data.kind_of?(Array)
          data.each do |elem|
            post_invoice(data, vendor)
          end
        end
      end
    end
  end
end
