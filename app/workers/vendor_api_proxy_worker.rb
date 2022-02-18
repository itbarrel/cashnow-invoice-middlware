# frozen_string_literal: true

class VendorApiProxyWorker
  include Sidekiq::Worker

  def post_document(data_to_post, vendor)
    formated_time = Time.now.in_time_zone('Asia/Karachi').strftime('%a, %d %B %Y')
    # formated_time = Time.now.in_time_zone('Asia/Karachi').strftime('%a, %d %B %Y %I:%M %p')
    ig = DocumentGroup.where(title: formated_time, vendor: vendor).first_or_create
    duplicate_documents = ig.documents.where("data->>'vendor_document_no' = ?", data_to_post['vendor_document_no'])
    data_to_post['vendor_document_date'] = data_to_post['vendor_document_date'].to_date.strftime('%d-%b-%Y')
    if duplicate_documents.length.zero?
      Document.create(data: data_to_post, document_group: ig)
    else
      duplicate_documents.first.update(data: data_to_post)
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

    client_proxy_obj = ClientProxy.new(client_id)

    return unless api.fetch_data?

    response = client_proxy_obj.fetch_data_for(api, vendor)
    response = JSON.parse(response[:message])
    # response.['vendor_document_date'].to_date.strftime('%d-%b-%y')
    error = response['error']
    data = response['data']
    # response['vendor_document_date'].to_date.strftime('%d/%m/%y')
    # data['vendor_document_date'].to_date.strftime('%d/%m/%y')

    # if success in response
    if error == false
      if data.is_a?(Array)
        data.each do |elem|
          post_document(elem, vendor)
        end
      else
        post_document(data, vendor)
      end
    elsif data.is_a?(Array)
      data.each do |_elem|
        post_document(data, vendor)
      end
    end
  end
end
