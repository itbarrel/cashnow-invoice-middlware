class Api::V1::DocumentsController < Api::V1::ApiController
    def index
        service = DocumentService.new
        query = params[:query] || {}
        query[:vendor_invoice_no_eq] = params[:vendor_invoice_no]
        render json: service.all(query)
    end
end
