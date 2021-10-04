class VendorsController < ApplicationController
  before_action :find_client
  before_action :find_vendor, only: %i[ show edit update destroy ]
  
  def index
    @vendors = @client.vendors
  end

  def show
  end

  def new
    @vendor = @client.vendors.build
  end

  def create
    @vendor = @client.vendors.build(vendor_params)
    respond_to do |format|   
      if @vendor.save   
        format.html { redirect_to client_vendors_url, notice: 'vendor was successfully created.' }   
        format.json { render :show, status: :created, location: @vendor }   
      else   
        format.html { render :new }   
        format.json { render json: @vendor.errors, status: :unprocessable_entity } 
      end
    end
  end

  def update
    respond_to do |format|
      if @vendor.update(vendor_params)
                format.html { redirect_to client_vendors_path, notice: "vendor was successfully updated." }
                format.json { render :show, status: :ok, location: @vendor }
      else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @vendor.errors, status: :unprocessable_entity }
        end
      end 
  end

  def destroy
  end
  private
  def find_vendor
    @vendor = @client.vendors.find(params[:id])
  end

  def find_client
    @client = Client.find(params[:client_id]) if params[:client_id].present?
  end

  def vendor_params
    params.require(:vendor).permit(:vendor_code)
  end

end
