class InvoiceGroupsController < ApplicationController
    before_action :find_invoice_group, only: %i[show update destroy]
    skip_before_action :verify_authenticity_token, :only => [:update]

    def show
        @invoices = @ig.filtered_invoices((params[:search][:from_date] rescue nil), (params[:search][:to_date] rescue nil))

        respond_to do |format|
            format.csv { send_data @invoices.to_csv, filename: "#{@ig.title}.csv" }
            format.xls { headers["Content-Disposition"] = "attachment; filename=\"#{@ig.title}.xls\"" }
            @ig.update(downloaded: true)
        end
    end

    def update
        @ig.update(ig_params)
    end

     def destroy
       @ig.destroy  
     end

    private

    def find_invoice_group
        @ig = InvoiceGroup.find(params[:id]) if params[:id].present?
    end

    def ig_params
        params.require(:invoice_group).permit(:downloaded)
    end
end
