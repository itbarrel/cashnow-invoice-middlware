class InvoicesController < ApplicationController
  before_action :find_vendor
  before_action :find_invoice, only: %i[destroy]

  def index
    if params[:search] && params[:search][:created_at].present?
      start_date, end_date = params[:search][:created_at].split(' - ')
      @invoice_groups = @vendor.invoices.having_created_at_between(start_date, end_date)
    else
      @invoice_groups = @vendor.invoice_groups
    end
    respond_to do |format|
      format.html
      format.csv { send_data @vendor.invoices.to_csv, filename: "#{Date.today}.csv" }
    end
  end

  def destroy
    @invoice.destroy
  end

  private

  def find_vendor
    @vendor = Vendor.find(params[:vendor_id]) if params[:vendor_id].present?
  end

  def find_invoice
    @invoice = @vendor.invoices.find(params[:id])
  end
end
