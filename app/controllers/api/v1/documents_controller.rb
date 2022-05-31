# frozen_string_literal: true

class Api::V1::DocumentsController < Api::V1::ApiController
  def index
    service = DocumentService.new
    query = params[:query] || {}
    query[:vendor_invoice_no_eq] = params[:vendor_invoice_no]
    render json: service.all(query)
  end

  def create
    grouped_docs = document_params[:document].group_by { |x| x['vendor_id'] }
    grouped_docs.each do |obj_key, obj_value|
      vendor = Vendor.find_by_id(obj_key)
      next if vendor.nil?

      formated_time = Time.now.in_time_zone('Asia/Karachi').strftime('%a, %d %B %Y')
      document_group = vendor.document_groups.create(title: formated_time)
      obj_value.each do |docx|
        document_group.documents.create(data: docx[:data])
      end
    end
    render json: { message: 'document successfully created. ' }, status: 200
  end

  def update
    if @vendor
      @vendor.update(vendor_params)
      render json: { message: 'Vendor successfully update. ' }, status: 200
    else
      render json: { error: 'Unable to update Vendor. ' }, status: 400
    end
  end

  # DELETE /Vendors/:id
  def destroy
    if @vendor
      @vendor.destroy
      render json: { message: 'Vendor successfully deleted. ' }, status: 200
    else
      render json: { error: 'Unable to delete Vendor. ' }, status: 400
    end
  end

  private

  def document_params
    params.permit(document: [:vendor_id, { data: {} }])
  end
end
