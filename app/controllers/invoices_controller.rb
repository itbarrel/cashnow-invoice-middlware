class InvoicesController < ApplicationController
  before_action :find_vendor
  before_action :find_invoice, only: %i[destroy]

  def index
    @invoice_groups = @vendor.invoice_groups

    if params[:search] && params[:search][:from_date].present?
      start_date = params[:search][:from_date]
      @invoice_groups = @invoice_groups.joins(:invoices).where("(invoices.data->>'vendor_invoice_date')::date > ?", start_date.to_date).distinct
    end

    if params[:search] && params[:search][:to_date].present?
      end_date = params[:search][:to_date]
      @invoice_groups = @invoice_groups.joins(:invoices).where("(invoices.data->>'vendor_invoice_date')::date < ?", end_date.to_date).distinct
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
