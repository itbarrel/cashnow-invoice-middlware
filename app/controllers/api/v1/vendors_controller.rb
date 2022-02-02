class Api::V1::VendorsController < Api::V1::ApiController
    before_action :find_client , only: %i[create]
    def index
        service = VendorService.new
        query = params[:query] || {}
        query[:client_id_eq] = params[:client_id]
        query[:vendor_code_eq] = params[:vendor_code]
        render json: service.all(query)
    end
    def create
        @vendor = @client.vendors.build(vendor_params)
        if @vendor.save
            render json: @vendor
        else
            render error: { error: 'Unable to create Vendor.' }, status: 400
        end 
    end
    private
    def find_client
        @client = Client.first
    end
    def vendor_params
        params.require(:vendor).permit(:vendor_code, :name , :client_id)
    end
end
