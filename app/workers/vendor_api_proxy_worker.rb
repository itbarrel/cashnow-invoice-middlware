class VendorApiProxyWorker
  include Sidekiq::Worker

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
      error = response['error']
      
      # if success in response 
      if error == false
        data = response['data']
        if data.kind_of?(Array)
          data.each do |elem|
            formated_time = Time.now.in_time_zone('Asia/Karachi').strftime('%a, %d %B %Y %I:%M %p')
            ig = InvoiceGroup.where(title: formated_time, vendor: vendor).first_or_create
            Invoice.create(data: elem, invoice_group: ig)
          end
        end
      else
        formated_time = Time.now.in_time_zone('Asia/Karachi').strftime('%a, %d %B %Y %I:%M %p')
        ig = InvoiceGroup.where(title: formated_time, vendor: vendor).first_or_create
        Invoice.create(data: data, invoice_group: ig)
      end
    end
  end
end
