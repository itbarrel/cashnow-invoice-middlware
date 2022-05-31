# frozen_string_literal: true

class Api::V1::VendorsController < Api::V1::ApiController
  before_action :find_vendor, only: %i[update destroy]
  def index
    service = VendorService.new
    query = params[:query] || {}
    query[:client_id_eq] = @current_client.id
    query[:vendor_code_eq] = params[:vendor_code]
    render json: service.all(query)
  end

  def create
    @vendor = @current_client.vendors.build(vendor_params)
    if @vendor.save
      render json: @vendor
    else
      render error: { error: 'Unable to create Vendor.' }, status: 400
    end
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

  def find_vendor
    @vendor = @current_client.vendors.find(params[:id])
  end

  def vendor_params
    params.require(:vendor).permit(:vendor_code, :name, :client_id)
  end
end
