class InvoiceGroupsController < ApplicationController
    before_action :find_invoice_group, only: %i[show destroy] 

    def show
        @invoices = @ig.invoices

        respond_to do |format|
            format.csv { send_data @invoices.to_csv, filename: "#{Date.today}.csv" }
        end
    end

     def destroy
       @ig.destroy  
     end
     


    private

    def find_invoice_group
        @ig = InvoiceGroup.find(params[:id]) if params[:id].present?
    end
end
